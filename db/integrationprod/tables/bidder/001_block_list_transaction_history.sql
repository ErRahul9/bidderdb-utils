create table bidder.block_list_transaction_history (
  id integer primary key not null ,
  timestamp timestamp without time zone default CURRENT_TIMESTAMP,
  site text,
  advertiser_id integer,
  append boolean,
  list_id integer
);

