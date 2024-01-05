create table bidder.advertiser_settings (
  advertiser_id integer primary key not null,
  pmp_whitelist_eligible boolean not null default false,
  xandr_seat_registered boolean
);

