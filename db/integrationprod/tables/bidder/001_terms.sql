create table bidder.terms (
  term_id integer primary key not null,
  weight integer not null,
  rank_num integer not null,
  delivery_modifier_id integer not null,
  active boolean
);
create unique index terms_delivery_modifier_id_rank_num_key on bidder.terms using btree (delivery_modifier_id, rank_num);

