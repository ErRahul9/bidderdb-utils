create table sync.campaign_budgets
(
    campaign_id integer                 not null
        primary key,
    budget      bigint                  not null,
    duration    integer                 not null,
    create_time timestamp default now() not null,
    update_time timestamp default now() not null
);

alter table sync.campaign_budgets
    owner to qacore;
