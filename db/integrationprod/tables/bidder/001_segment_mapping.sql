CREATE SEQUENCE IF NOT EXISTS bidder.segment_mapping_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;



create table bidder.segment_mapping (
  id integer primary key not null default nextval('bidder.segment_mapping_id_seq'::regclass),
  segment_id integer not null,
  campaign_id integer not null,
  action text not null,
  create_time timestamp without time zone not null default CURRENT_TIMESTAMP,
  update_time timestamp without time zone
);
create unique index segment_unique_constraint on bidder.segment_mapping using btree (segment_id);
