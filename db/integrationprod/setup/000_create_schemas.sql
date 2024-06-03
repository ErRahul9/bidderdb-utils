alter ROLE postgres WITH  PASSWORD 'password';
CREATE ROLE root WITH LOGIN;
CREATE ROLE qacore WITH LOGIN;


-- CREATE ROLE qasync_automated_user WITH LOGIN;
-- ALTER USER root WITH PASSWORD 'password';



-- DROP SCHEMA IF EXISTS dso ;

CREATE SCHEMA IF NOT EXISTS dso
    AUTHORIZATION postgres;

-- DROP SCHEMA IF EXISTS core ;

CREATE SCHEMA IF NOT EXISTS core
    AUTHORIZATION postgres;


-- SCHEMA: summarydata

-- DROP SCHEMA IF EXISTS summarydata ;

CREATE SCHEMA IF NOT EXISTS summarydata
    AUTHORIZATION postgres;

-- DROP SCHEMA IF EXISTS bidder ;

CREATE SCHEMA IF NOT EXISTS bidder
    AUTHORIZATION postgres;


CREATE SCHEMA IF NOT EXISTS public
    AUTHORIZATION postgres;

-- DROP SCHEMA IF EXISTS sync;
CREATE SCHEMA IF NOT EXISTS sync
    AUTHORIZATION postgres;

CREATE SCHEMA IF NOT EXISTS report
    AUTHORIZATION postgres;

CREATE SCHEMA IF NOT EXISTS test
    AUTHORIZATION postgres;


GRANT SELECT, INSERT, DELETE, UPDATE ON ALL TABLES IN SCHEMA bidder TO qacore;
GRANT SELECT, INSERT, DELETE, UPDATE ON ALL TABLES IN SCHEMA core TO qacore;
GRANT SELECT, INSERT, DELETE, UPDATE ON ALL TABLES IN SCHEMA sync TO qacore;
GRANT SELECT, INSERT, DELETE, UPDATE ON ALL TABLES IN SCHEMA dso TO qacore;
GRANT SELECT, INSERT, DELETE, UPDATE ON ALL TABLES IN SCHEMA test TO qacore;
GRANT SELECT, INSERT, DELETE, UPDATE ON ALL TABLES IN SCHEMA public TO qacore;

ALTER database integrationdb set search_path to override, pg_catalog, "$user", public, core, bidder,sync,dso,test;
ALTER ROLE ALL set search_path to override, pg_catalog, "$user", public, core, bidder,sync,dso,test;