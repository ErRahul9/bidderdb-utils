CREATE SEQUENCE IF NOT EXISTS core.creative_groups_group_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;


create table core.creative_groups
(
    group_id                     integer   default nextval('creative_groups_group_id_seq'::regclass) not null
        primary key,
    campaign_id                  integer                                                             not null,
    name                         text                                                                not null,
    click_url                    text,
    weight                       integer                                                             not null,
    imp_limit_day                integer,
    imp_limit_user_day           integer,
    active                       boolean   default true                                              not null,
    escalating_order             integer,
    escalation_type_id           smallint,
    escalation_limit             smallint,
    control_percentage           integer   default 0                                                 not null,
    is_control                   boolean   default false,
    url_prefix                   text,
    url_suffix                   text,
    dpp_id                       text,
    impression_tracking          text,
    mycreative_group_id          integer,
    template_group_id            integer,
    snapshot                     text,
    update_time                  timestamp default now(),
    create_time                  timestamp default now(),
    description                  text,
    dpp_filter                   text,
    display_url                  text,
    parent_group_id              integer,
    ordinal                      integer,
    mycreative_video_group_id    integer,
    user_id                      integer,
    has_dynamic                  boolean   default false,
    override_impression_tracking boolean   default false                                             not null,
    override_visit_tracking      boolean   default false                                             not null,
    ui_creative_group_id         integer
);

alter table core.creative_groups
    owner to qacore;
