CREATE SEQUENCE IF NOT EXISTS bidder.delivery_modifiers_delivery_modifier_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;



create table bidder.delivery_modifiers (
  delivery_modifier_id integer primary key not null default nextval('bidder.delivery_modifiers_delivery_modifier_id_seq'::regclass),
  active boolean not null,
  campaign_id integer not null
);