
create table bidder.beeswax_segment_mapping (
  steelhouse_id integer primary key ,
  beeswax_segment_key integer
);

alter table bidder.beeswax_segment_mapping
    owner to qacore;