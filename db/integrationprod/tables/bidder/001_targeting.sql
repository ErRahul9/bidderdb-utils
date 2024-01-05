create table bidder.targeting (
  comparator text,
  expanded boolean not null default false,
  target_value text,
  active boolean not null default false,
  target_id bigint primary key not null,
  targeting_module text,
  term_id integer
);
