CREATE SEQUENCE IF NOT EXISTS bidder.deal_volume_log_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;



create table bidder.deal_volume_log (
  id integer primary key not null default nextval('bidder.deal_volume_log_id_seq'::regclass),
  percent integer not null,
  deal_id text not null,
  action text not null,
  updated_on timestamp without time zone not null
);
create index deal_update_idx on bidder.deal_volume_log using btree (deal_id, updated_on);
