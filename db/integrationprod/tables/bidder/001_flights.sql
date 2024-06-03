create table bidder.flights
(
    id                       serial not null,
    flight_id                bigint                  not null,
    campaign_group_id        integer                 not null,
    start_time               timestamp               not null,
    end_time                 timestamp               not null,
    active                   boolean   default false not null,
    hourly_budget_cap_micros bigint                  not null,
    flight_budget_cap_micros bigint                  not null,
    hourly_impression_cap    integer,
    flight_impression_cap    integer,
    create_time timestamp without time zone not null default CURRENT_TIMESTAMP,
    update_time timestamp without time zone
);

alter table bidder.flights
    owner to qacore;
--
-- create unique index flights_flight_id_index
--     on bidder.flights (flight_id);
--
-- create index flights_campaign_group_id_index
--     on bidder.flights (campaign_group_id);
--
-- create index flights_start_time_index
--     on bidder.flights (start_time);
--
-- create index flights_end_time_index
--     on bidder.flights (end_time);
--
-- create function modify_update_time() returns trigger
--     language plpgsql
-- as
-- $$
-- BEGIN
--     NEW.update_time = now();
--     RETURN NEW;
-- END;
-- $$;
--
-- alter function modify_update_time() owner to qacore;
--
-- grant execute on function modify_update_time() to qacore;
--
--
--
-- create trigger update_flights_update_time
--     before update
--     on bidder.flights
--     for each row
-- execute procedure modify_update_time();
--
