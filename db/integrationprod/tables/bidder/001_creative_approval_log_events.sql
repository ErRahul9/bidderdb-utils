CREATE SEQUENCE IF NOT EXISTS bidder.creative_approval_log_events_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;


create table bidder.creative_approval_log_events (
  id integer primary key not null default nextval('bidder.creative_approval_log_events_id_seq'::regclass),
  creative_id integer not null,
  status integer not null,
  partner integer not null,
  create_time timestamp without time zone not null default now(),
  audit_feedback character varying,
  description character varying
);
