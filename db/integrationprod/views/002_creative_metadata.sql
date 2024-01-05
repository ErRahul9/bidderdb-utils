-- create table sync.creative_metadata
--             (campaign_id int,
--              advertiser_id int,
--              width int,
--              height int,
--              duration int,
--              partner_creative_id int,
--              line_item_id int,
--              recency_threshold int,
--              budget_pace int,
--               household_score_threshold int,
--               viewability_score_threshold int,
--               cpm_threshold int,
--               performance_threshold int,
--              pace_multiplier int,
--               objective_id int,
--               channel_id int,
--               name text,
--               hourly_budget int,
--               device_type_budget_percent int,
--              recency_floor_threshold int,
--               campaign_group_id int);
-- drop view if exists sync.creative_metadata;

create view sync.creative_metadata as
SELECT DISTINCT campaigns.campaign_id,
                c.advertiser_id,
                size.width,
                size.height,
                CASE
                    WHEN c.length = 15 THEN 30
                    WHEN c.length IS NULL AND size.width = 1920 THEN 30
                    ELSE c.length::integer
                    END                            AS duration,
                b.partner_id::text                 AS partner_creative_id,
                beeswaxcampaign.line_item_id::text AS line_item_id,
                campaign_thresholds.recency_threshold,
                campaign_thresholds.budget_pace,
                campaign_thresholds.household_score_threshold,
                campaign_thresholds.viewability_score_threshold,
                campaign_thresholds.cpm_threshold,
                campaign_thresholds.performance_threshold,
                pace_multipliers.pace_multiplier,
                campaigns.objective_id,
                campaigns.channel_id,
                rt.name,
                cb.hourly_budget,
                cbbd.device_type_groups::text      AS device_type_budget_percent,
                campaign_thresholds.recency_floor_threshold,
                campaigns.campaign_group_id
FROM campaigns
         JOIN creative_groups USING (campaign_id)
         JOIN creative_groups_x_creatives USING (group_id)
         JOIN core.creatives c USING (creative_id)
         JOIN sync.beeswax_creative_x_size x ON x.sh_creative_id = c.creative_id
         JOIN sync.beeswax_creative_mapping b ON x.campaign_x_size_id = b.steelhouse_id
         JOIN core.creative_sizes size ON c.creative_size_id = size.creative_size_id
         JOIN sync.beeswax_campaign_mapping beeswaxcampaign ON campaigns.campaign_id = beeswaxcampaign.steelhouse_id
         LEFT JOIN bidder.recency_mappings rm
                   ON rm.channel_id = campaigns.channel_id AND rm.objective_id = campaigns.objective_id
         LEFT JOIN bidder.recency_types rt ON rm.recency_type_id = rt.recency_type_id
         LEFT JOIN sync.campaign_thresholds ON campaigns.campaign_id = campaign_thresholds.campaign_id
         LEFT JOIN sync.pace_multipliers ON campaigns.campaign_id = pace_multipliers.campaign_id AND
                                            campaigns.advertiser_id = pace_multipliers.advertiser_id AND
                                            campaigns.campaign_group_id = pace_multipliers.campaign_group_id
         LEFT JOIN (SELECT cb_1.budget AS hourly_budget,
                           cb_1.campaign_id
                    FROM sync.campaign_budgets cb_1
                    WHERE cb_1.duration = 3600) cb ON campaigns.campaign_id = cb.campaign_id
         LEFT JOIN bidder.campaign_budget_by_device cbbd ON campaigns.campaign_id = cbbd.campaign_id
WHERE (campaigns.campaign_status_id = ANY (ARRAY [1, 3]))
  AND campaigns.campaign_group_id IS NOT NULL
  AND (campaigns.end_time IS NULL OR campaigns.end_time >= now())
  AND (campaigns.deleted IS NULL OR campaigns.deleted = false)
  AND campaigns.channel_id IS NOT NULL;

alter table sync.creative_metadata
    owner to qacore;

