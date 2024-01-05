-- create table bidder.eligible_campaigns
--             (campaign_id int ,
--              advertiser_id int,
--              name text,
--              start_time timestamp(6)  ,
--              end_time timestamp(6)  ,
--              campaign_group_id int,
--              objective_id int,
--              channel_id int,
--              cap int,
--              fcap_duration int,
--               time_zone text,
--               currency int,
--               company_url text,
--               campaign_status_id int,
--               deleted int,
--               pace_multiplier int,
--              recency_threshold int,
--               household_score_threshold int,
--               viewability_score_threshold int,
--               recency_type text,
--               partner_id int);

create view bidder.eligible_campaigns
            (campaign_id, advertiser_id, name, start_time, end_time, campaign_group_id, objective_id, channel_id, cap,
             fcap_duration, time_zone, currency, company_url, campaign_status_id, deleted, pace_multiplier,
             recency_threshold, household_score_threshold, viewability_score_threshold, recency_type, partner_id)
as
SELECT c.campaign_id,
       c.advertiser_id,
       c.name,
       c.start_time,
       c.end_time,
       c.campaign_group_id,
       c.objective_id,
       c.channel_id,
       fcap.cap,
       fcap.duration AS fcap_duration,
       a.time_zone,
       a.currency,
       a.company_url,
       c.campaign_status_id,
       c.deleted,
       pace_multipliers.pace_multiplier,
       campaign_thresholds.recency_threshold,
       campaign_thresholds.household_score_threshold,
       campaign_thresholds.viewability_score_threshold,
       rt.name       AS recency_type,
       c.partner_id
FROM campaigns c
         LEFT JOIN dso.frequency_caps fcap ON c.campaign_id = fcap.campaign_id
         LEFT JOIN public.advertisers a ON c.advertiser_id = a.advertiser_id
         LEFT JOIN sync.pace_multipliers ON c.campaign_id = pace_multipliers.campaign_id AND
                                            c.advertiser_id = pace_multipliers.advertiser_id AND
                                            c.campaign_group_id = pace_multipliers.campaign_group_id
         LEFT JOIN sync.campaign_thresholds ON c.campaign_id = campaign_thresholds.campaign_id
         LEFT JOIN bidder.recency_mappings rm ON rm.channel_id = c.channel_id AND rm.objective_id = c.objective_id
         LEFT JOIN bidder.recency_types rt ON rm.recency_type_id = rt.recency_type_id
WHERE c.partner_id = 22;

alter table bidder.eligible_campaigns
    owner to qacore;
