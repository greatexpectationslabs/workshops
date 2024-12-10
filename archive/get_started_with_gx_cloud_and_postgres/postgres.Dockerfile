FROM postgres:15.3-alpine as dumper

RUN apk update && \
    apk upgrade && \
    apk add curl

# Copy the taxi data dump file from the great-expectations repo.
ARG NYC_TAXI_DATA_URL=https://raw.githubusercontent.com/great-expectations/great_expectations/develop/examples/reference_environments/postgres/db_dump.sql
RUN curl $NYC_TAXI_DATA_URL -o /docker-entrypoint-initdb.d/nyc_taxi_data.sql

# Remove the exec "$@" content that exists in the docker-entrypoint.sh file
# so it will not start the PostgreSQL daemon (we don’t need it on this step).
RUN ["sed", "-i", "s/exec \"$@\"/echo \"skipping...\"/", "/usr/local/bin/docker-entrypoint.sh"]

ENV POSTGRES_USER=example_user
ENV POSTGRES_HOST_AUTH_METHOD=trust
ENV POSTGRES_DB=gx_example_db
ENV PGDATA=/data

# Execute the entrypoint itself. It will execute the dump and load the data dump
# into the /data folder.
RUN ["/usr/local/bin/docker-entrypoint.sh", "postgres"]

FROM postgres:15.3-alpine

# This will copy all files from /data folder from the dump step into the $PGDATA
# from this current step, making our data preloaded when we start the container
# (without needing to run the dump every time we create a new container).
COPY --from=dumper /data $PGDATA