FROM postgres:11.16

ENV POSTGRES_PASSWORD password
ENV POSTGRES_USER postgres
ENV POSTGRES_DB integrationdb

COPY db/integrationprod/setup/000_create_schemas.sql /docker-entrypoint-initdb.d/
#COPY db/integrationprod/setup/00_setup.sql /docker-entrypoint-initdb.d/
COPY db/integrationprod/tables/bidder/*.sql /docker-entrypoint-initdb.d/
COPY db/integrationprod/tables/dso/*.sql /docker-entrypoint-initdb.d/
COPY db/integrationprod/tables/public/*.sql /docker-entrypoint-initdb.d/
COPY db/integrationprod/tables/sync/*.sql /docker-entrypoint-initdb.d/
COPY db/integrationprod/tables/core/*.sql /docker-entrypoint-initdb.d/
COPY db/integrationprod/views/*.sql /docker-entrypoint-initdb.d/
#COPY db/integrationprod/setup/data/*.sql /docker-entrypoint-initdb.d/


#bidder.recency_mappings

#COPY tables/**/*.sql /docker-entrypoint-initdb.d/
#COPY views/*.sql /docker-entrypoint-initdb.d/
#COPY setup/**/*.sql /docker-entrypoint-initdb.d/
#COPY views/*.sql /docker-entrypoint-initdb.d/
#RUN #find /docker-entrypoint-initdb.d -name "cleanup*" -delete

# latest_dco_run.sql is a view but is in the tables folder. Removing from startup
#RUN #rm "/docker-entrypoint-initdb.d/ latest_dco_run.sql"
#COPY db/integrationprod/views/*.sql /docker-entrypoint-initdb.d/

# Copy additional tables required by DCO but not included in dco-utils
#COPY services/integrationdb/**/*.sql /docker-entrypoint-initdb.d/
#COPY integrationprod/views/**/*.sql /docker-entrypoint-initdb.d/