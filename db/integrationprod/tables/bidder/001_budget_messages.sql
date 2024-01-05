create table bidder.budget_messages (
  advertiser_id integer not null,
  campaign_group_id integer,
  campaign_id integer not null,
  duration integer not null,
  transaction_id text not null,
  type text not null,
  timestamp timestamp without time zone not null,
  id text primary key not null,
  budget numeric(15,4)
);