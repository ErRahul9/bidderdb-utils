FROM postgres:11.16

ENV POSTGRES_PASSWORD password
#ENV POSTGRES_USER postgres
ENV POSTGRES_DB integrationdb

#COPY bidderdb-utils/db
COPY ./db/integrationprod/setup/000_create_schemas.sql /docker-entrypoint-initdb.d/
COPY ./db/integrationprod/tables/*/*.* /docker-entrypoint-initdb.d/
#COPY ./db/integrationprod/tables/bidder/*.sql /docker-entrypoint-initdb.d/
#COPY ./db/integrationprod/tables/dso/*.sql /docker-entrypoint-initdb.d/
#COPY ./db/integrationprod/tables/public/*.sql /docker-entrypoint-initdb.d/
#COPY ./db/integrationprod/tables/sync/*.sql /docker-entrypoint-initdb.d/
#COPY ./db/integrationprod/tables/core/*.sql /docker-entrypoint-initdb.d/
COPY ./db/integrationprod/views/*.* /docker-entrypoint-initdb.d/
COPY ./db/integrationprod/setup/data/*.* /docker-entrypoint-initdb.d/

EXPOSE 5432

CMD ["postgres"]
