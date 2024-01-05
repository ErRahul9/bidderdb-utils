create table bidder.recency_mappings (
  objective_id integer not null,
  channel_id integer not null,
  recency_type_id integer not null,
  primary key (objective_id, channel_id)
);