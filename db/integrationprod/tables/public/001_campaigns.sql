CREATE SEQUENCE IF NOT EXISTS public.campaign_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;



create table public.campaigns
(
    campaign_id                  integer        not null  DEFAULT nextval('campaign_id_seq'::regclass) primary key,
    advertiser_id                integer                                                              not null,
    name                         text                                                                 not null,
    description                  text,
    start_time                   timestamp(6)                                                         not null,
    end_time                     timestamp(6),
    create_time                  timestamp(6)  default now(),
    control_percentage           integer       default 0                                              not null,
    is_test                      boolean       default false                                          not null,
    clickpass_click_ttl          interval(6),
    is_click_opt                 boolean       default false                                          not null,
    campaign_group_id            integer,
    deleted                      boolean       default false,
    partner_channel_objective_id integer,
    campaign_status_id           integer       default 0,
    click_url                    text,
    update_time                  timestamp(6)  default now(),
    objective_id                 integer,
    channel_id                   integer,
    partner_id                   integer,
    fb_ad_type_id                integer,
    campaign_template_id         integer,
    segmentation_default_id      integer,
    dso_manage_budget            boolean       default true                                           not null,
    audience_type_id             integer,
    audience_source_id           integer,
    budget_floor                 numeric(3, 2) default 0                                              not null,
    budget_ceiling               numeric(3, 2) default 1                                              not null,
    user_id                      integer,
    funnel_level                 integer,
    gaclid_enabled               boolean
);

alter table public.campaigns
    owner to qacore;
