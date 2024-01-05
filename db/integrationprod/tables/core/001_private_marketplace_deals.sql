CREATE SEQUENCE IF NOT EXISTS core.campaign_x_audiences_campaign_x_audience_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;


create table core.private_marketplace_deals
(
    private_marketplace_deal_id serial primary key,
    partner_deal_id             text                       not null,
    user_id                     integer                    not null,
    floor_price                 numeric(10, 2),
    name                        text,
    partner_id                  integer                    not null,
    start_time                  timestamp(6),
    end_time                    timestamp(6),
    active                      boolean      default true  not null,
    min_budget                  numeric(10, 2),
    max_budget                  numeric(10, 2),
    deal_type_id                integer      default 2,
    create_time                 timestamp(6) default now() not null,
    update_time                 timestamp(6)               not null,
    channel_id                  integer      default 8,
    dsp_partner_id              integer,
    audit_user_id               integer,
    pricing_model               text,
    partnership_deal_type       text
);

alter table core.private_marketplace_deals
    owner to qacore;


