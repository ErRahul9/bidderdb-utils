create table if not exists core.creative_groups_x_creatives
(
    group_id            integer              not null,
    creative_id         integer              not null,
    click_url           text,
    active              boolean default true not null,
    url_prefix          text,
    url_suffix          text,
    dpp_id              text,
    impression_tracking text,
    dpp_filter          text,
    user_id             integer,
    primary key (group_id, creative_id)
);


