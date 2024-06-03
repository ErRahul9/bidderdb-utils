drop table if exists bidder.pmp_deal_allow_list;

create table bidder.pmp_deal_allow_list
(
    pmp_deal_allow_list_id  serial primary key,
    partner_deal_id         text                                not null,
    delivery_target_list_id bigint                              not null,
    active                  boolean   default true,
  create_time timestamp without time zone not null default CURRENT_TIMESTAMP,
  update_time timestamp without time zone
);

alter table bidder.pmp_deal_allow_list
    owner to qacore;



