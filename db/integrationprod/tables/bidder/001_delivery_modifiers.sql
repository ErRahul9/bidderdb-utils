-- CREATE SEQUENCE IF NOT EXISTS bidder.delivery_modifiers_delivery_modifier_id_seq
--     INCREMENT 1
--     START 1
--     MINVALUE 1
--     MAXVALUE 9223372036854775807
--     CACHE 1;
--
--
--
-- create table bidder.delivery_modifiers (
--   delivery_modifier_id integer primary key not null default nextval('bidder.delivery_modifiers_delivery_modifier_id_seq'::regclass),
--   active boolean not null,
--   campaign_id integer not null
-- );
-- drop table bidder.delivery_modifier_targets;
-- drop table bidder.delivery_modifier_terms;
-- drop table if exists bidder.delivery_modifiers;

-- create type bidder.delivery_modifier_object_type as enum ('campaign', 'campaign_group');
--
-- alter type bidder.delivery_modifier_object_type owner to qacore;
--


create table bidder.delivery_modifiers
(
    delivery_modifier_id serial primary key,
    active               boolean,
    object_id            integer,
    object_type          text
);

alter table delivery_modifiers
    owner to qacore;
--
-- create unique index delivery_modifiers_delivery_modifier_id_uindex
--     on delivery_modifiers (delivery_modifier_id);

