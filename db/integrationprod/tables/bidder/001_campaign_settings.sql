create table bidder.campaign_settings (
  campaign_id integer not null,
  pace_level integer,
  advertiser_id integer not null,
  pmp_traffic_override boolean,
  primary key (campaign_id, advertiser_id)
);
create unique index campaign_settings_pk on bidder.campaign_settings using btree (campaign_id, advertiser_id);
