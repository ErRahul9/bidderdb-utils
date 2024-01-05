CREATE SEQUENCE IF NOT EXISTS bidder.segment_mapping_transaction_logs_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;



create table bidder.segment_mapping_transaction_logs (
  id integer not null default nextval('bidder.segment_mapping_transaction_logs_id_seq'::regclass),
  segment_id integer not null,
  campaign_id integer not null,
  create_time timestamp without time zone not null default CURRENT_TIMESTAMP
);
