CREATE SEQUENCE IF NOT EXISTS core.campaign_x_audiences_campaign_x_audience_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;



create table core.campaign_x_audiences
(
    campaign_x_audience_id integer      default nextval('campaign_x_audiences_campaign_x_audience_id_seq'::regclass) not null
        constraint campaign_x_audience_pk
            primary key,
    campaign_id            integer                                                                                   not null,
    audience_id            integer                                                                                   not null,
    create_time            timestamp(6) default now(),
    segment_id             integer,
    user_id                integer,
    constraint campaignxaudiences_cidnaid
        unique (campaign_id, audience_id)
);

alter table core.campaign_x_audiences
    owner to qacore;



