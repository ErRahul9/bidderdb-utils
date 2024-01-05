CREATE SEQUENCE IF NOT EXISTS bidder.creative_approval_temp_creative_approval_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;



create table bidder.creative_approval_temp (
  creative_approval_id integer primary key not null default nextval('bidder.creative_approval_temp_creative_approval_id_seq'::regclass),
  advertiser_id integer not null,
  campaign_id integer not null,
  campaign_group_id integer not null,
  creative_id integer not null,
  partner_creative_id text not null,
  status integer not null,
  rejection_reason text,
  partner_id integer not null,
  created timestamp without time zone not null default now(),
  creative_status_update timestamp without time zone not null default now(),
  resend_timestamp timestamp without time zone
);
create unique index creative_approval_temp_creative_id_partner_id_key on bidder.creative_approval_temp using btree (creative_id, partner_id);
