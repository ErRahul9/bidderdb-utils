create table bidder.term_targets (
  term_id integer not null,
  target_id bigint not null,
  primary key (term_id, target_id)
);
