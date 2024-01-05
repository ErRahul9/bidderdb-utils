create table test.publisher_adsize_metrics
            (site text,
             ad_format text,
             width int,
             height int,
             duration int,
             avg_cpi numeric,
             min_cpi numeric,
             max_cpi numeric,
             avg_cpm numeric,
             min_cpm numeric,
             max_cpm numeric,
            impressions int,
            viewable_impressions int,
            viewability_rate int,
            partner_id int,
              recommended_cpm int,
              creative_size int,
             video_length int,
              last_refresh_date timestamp(6),
              score int )