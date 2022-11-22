FROM            postgres

MAINTAINER      Nigel Jones <jonesn@uk.ibm.com>

ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=Admin999
ENV POSTGRES_HOST_AUTH_METHOD=md5

# Allow connections from anywhere.
RUN ls -latr /var/lib/postgresql
#RUN sed -i -e"s/^#listen_addresses =.*$/listen_addresses = '*'/" /var/lib/postgresql/data/postgresql.conf
RUN echo "host    all    all    0.0.0.0/0    md5" > /var/lib/postgresql/data/pg_hba.conf
RUN echo "password_encryption=md5" /var/lib/postgresql/data/postgreslq.conf
#COPY ./files/pg_hba.conf /var/lib/postgresql/data/pg_hba.conf
#COPY ./files/postgresql.conf /var/lib/postgresql/data/postgresql.conf

# Add dockerize wait tool
RUN apt-get update && apt-get install -y wget
RUN wget https://github.com/jwilder/dockerize/releases/download/v0.1.0/dockerize-linux-amd64-v0.1.0.tar.gz
RUN tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.1.0.tar.gz


# Nothing else needed here yet


