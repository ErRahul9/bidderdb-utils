create table test.publisher_adsize_metrics
            (site text,
             ad_format text,
             width int,
             height int,
             duration int,
             avg_cpi float,
             min_cpi float,
             max_cpi float,
             avg_cpm float,
             min_cpm float,
             max_cpm float,
             impressions int,
              viewable_impressions int,
              viewability_rate int,
              partner_id int,
              recommended_cpm int,
              creative_size int,
             video_length int,
              last_refresh_date timestamp(6),
              score int );
-- as;
-- missing source code


alter table test.publisher_adsize_metrics
    owner to qacore;

