#
# ---
# Docker configuration file for Ranger
#
# Nigel Jones
# may 2017
#
# Caveats:
#   * Lots of hardcoded paths
#   * No containers in use yet so data will be lost each time
# ---

# Let's use UBUNTU
FROM ubuntu:20.04 as builder

# any problems let me know
MAINTAINER      Nigel Jones <nigel.l.jones+gh@gmail.com>

# Will use these more in future

ENV		 rootpw			 admin99
ENV		 build 			 ranger-3.0.0-SNAPSHOT
ENV		 dadir			 /opt/ranger-3.0.0-SNAPSHOT-admin




# Let's start with some core packages we need
RUN apt-get update

## for apt to be noninteractive
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata




RUN apt-get install -y wget python3 python3-pip libpostgresql-jdbc-java libpostgresql-jdbc-java-doc python openjdk-8-jdk maven git iputils-ping net-tools vim lsof apt-utils build-essential lsb-core lsb-release

# It turns out mvn 3.5.3 (current on ubuntu distro) nor 3.5.2 work with ranger. 3.5.0 or 3.5.4 only
WORKDIR /root
RUN wget http://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz
RUN gunzip -c apache-maven-3.8.6-bin.tar.gz | tar -xvf -

# Setup some environment variables for later
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64


# Add Java 8 and Maven to the path.
ENV PATH /root/apache-maven-3.8.6/bin:/usr/lib/jvm/java-8-openjdk-amd64/bin:/usr/local/apache-maven/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

 # Working directory - root home
WORKDIR /root

 # Pull down Ranger and build it
RUN git clone http://github.com/apache/ranger.git -b master

 # Remove -DskipTests if unit tests are to be included - build the code...
WORKDIR /root/ranger
RUN mvn -DskipTests=true clean compile package install

# We have now built the latest ranger from source - let's unpack and setup the admin server & UI

# Add dockerize wait tool - this allows VMs to wait for network ports to be available.
# Only needed if running in a docker-compose type environment, not for single image
# this is recommended on docker.com
RUN wget https://github.com/jwilder/dockerize/releases/download/v0.6.1/dockerize-linux-amd64-v0.6.1.tar.gz
RUN tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.6.1.tar.gz


FROM ubuntu:20.04

# Will use these more in future

ENV		 rootpw			 admin99
ENV		 build 			 ranger-3.0.0-SNAPSHOT
ENV		 dadir			 /opt/ranger-3.0.0-SNAPSHOT-admin




# Let's start with some core packages we need
RUN apt-get update

## for apt to be noninteractive
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata




RUN apt-get install -y wget python3 python3-pip libpostgresql-jdbc-java libpostgresql-jdbc-java-doc python openjdk-8-jdk maven git iputils-ping net-tools vim lsof apt-utils build-essential lsb-core lsb-release

# We have now built the latest ranger from source - let's unpack and setup the admin server & UI

# Add dockerize wait tool - this allows VMs to wait for network ports to be available.
# Only needed if running in a docker-compose type environment, not for single image
# this is recommended on docker.com
RUN wget https://github.com/jwilder/dockerize/releases/download/v0.6.1/dockerize-linux-amd64-v0.6.1.tar.gz
RUN tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.6.1.tar.gz
RUN rm dockerize-linux-amd64-v0.6.1.tar.gz

WORKDIR /opt
COPY --from=builder /root/ranger/target/ranger-3.0.0-SNAPSHOT-admin.tar.gz /tmp


# After a build, the ranger directory looks like this - we need to chose the zips we're interested in deploying
# in this docker image
#
# antrun                                      ranger-2.0.0-SNAPSHOT-migration-util.tar.gz
# archive-tmp                                 ranger-2.0.0-SNAPSHOT-migration-util.zip
# maven-shared-archive-resources              ranger-2.0.0-SNAPSHOT-ranger-tools.tar.gz
# ranger-2.0.0-SNAPSHOT-admin.tar.gz          ranger-2.0.0-SNAPSHOT-ranger-tools.zip
# ranger-2.0.0-SNAPSHOT-admin.zip             ranger-2.0.0-SNAPSHOT-solr-plugin.tar.gz
# ranger-2.0.0-SNAPSHOT-atlas-plugin.tar.gz   ranger-2.0.0-SNAPSHOT-solr-plugin.zip
# ranger-2.0.0-SNAPSHOT-atlas-plugin.zip      ranger-2.0.0-SNAPSHOT-sqoop-plugin.tar.gz
# ranger-2.0.0-SNAPSHOT-hbase-plugin.tar.gz   ranger-2.0.0-SNAPSHOT-sqoop-plugin.zip
# ranger-2.0.0-SNAPSHOT-hbase-plugin.zip      ranger-2.0.0-SNAPSHOT-src.tar.gz
# ranger-2.0.0-SNAPSHOT-hdfs-plugin.tar.gz    ranger-2.0.0-SNAPSHOT-src.zip
# ranger-2.0.0-SNAPSHOT-hdfs-plugin.zip       ranger-2.0.0-SNAPSHOT-storm-plugin.tar.gz
# ranger-2.0.0-SNAPSHOT-hive-plugin.tar.gz    ranger-2.0.0-SNAPSHOT-storm-plugin.zip
# ranger-2.0.0-SNAPSHOT-hive-plugin.zip       ranger-2.0.0-SNAPSHOT-tagsync.tar.gz
# ranger-2.0.0-SNAPSHOT-kafka-plugin.tar.gz   ranger-2.0.0-SNAPSHOT-tagsync.zip
# ranger-2.0.0-SNAPSHOT-kafka-plugin.zip      ranger-2.0.0-SNAPSHOT-usersync.tar.gz
# ranger-2.0.0-SNAPSHOT-kms.tar.gz            ranger-2.0.0-SNAPSHOT-usersync.zip
# ranger-2.0.0-SNAPSHOT-kms.zip               ranger-2.0.0-SNAPSHOT-yarn-plugin.tar.gz
# ranger-2.0.0-SNAPSHOT-knox-plugin.tar.gz    ranger-2.0.0-SNAPSHOT-yarn-plugin.zip
# ranger-2.0.0-SNAPSHOT-knox-plugin.zip       rat.txt
# ranger-2.0.0-SNAPSHOT-kylin-plugin.tar.gz   version
# ranger-2.0.0-SNAPSHOT-kylin-plugin.zip

# Just going with the admin server here - v1 of the docker image used to copy in, so here we will just link

WORKDIR /opt
RUN gunzip -c /tmp/ranger-3.0.0-SNAPSHOT-admin.tar.gz | tar -xvf -
RUN rm /tmp/ranger-3.0.0-SNAPSHOT-admin.tar.gz


# Get the mysql connector ready

# Setup solr - needs java, contributed script for local solr install
#
# Script#s default port is 6083. 
WORKDIR /opt/ranger-3.0.0-SNAPSHOT-admin/contrib/solr_for_audit_setup
RUN sed -i 's|SOLR_INSTALL=false|SOLR_INSTALL=true|' install.properties
RUN sed -i 's|SOLR_DOWNLOAD_URL=|SOLR_DOWNLOAD_URL=http://dlcdn.apache.org/lucene/solr/8.11.2/solr-8.11.2.tgz|' install.properties

#Update path to include java, so that when we run the container it is available
#default shell isn't bash :-(

#RUN echo "export JAVA_HOME=/usr/lib/jvm/default-java" >> /root/.bashrc
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /root/.profile
RUN echo "export PATH=${JAVA_HOME}/bin:$PATH" >> /root/.profile
RUN chmod +x /root/.profile


# This should work according to docs, but see RANGER-1565 -
#
# --RUN sed -i 's|#JAVA_HOME=|JAVA_HOME=/usr/lib/jvm/default-java|' install.properties
# --RUN ./setup.sh
#
# So this is the workaround
RUN sed -i '29d' setup.sh
RUN cat setup.sh
RUN JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 ./setup.sh

# setup the ranger server

WORKDIR /opt/ranger-3.0.0-SNAPSHOT-admin
RUN ls -latr /usr/share/java
RUN cat "${dadir}/install.properties"
RUN set -i 's|^#setup_mode=SeparateDBA|setup_mode=SeparateDBA|g' "${dadir}/install.properties"
RUN sed -i 's|^DB_FLAVOR=MYSQL|DB_FLAVOR=POSTGRES|g' "${dadir}/install.properties"
RUN sed -i 's|^SQL_CONNECTOR_JAR=/usr/share/java/mysql-connector-java.jar|SQL_CONNECTOR_JAR=/usr/share/java/postgresql.jar|g' "${dadir}/install.properties"
RUN sed -i 's|^db_root_user=root|db_root_user=postgres|g' "${dadir}/install.properties"
RUN sed -i 's|^db_root_password=|db_root_password=Admin99|g' "${dadir}/install.properties"
RUN sed -i 's|^db_password=|db_password=admin|g' "${dadir}/install.properties" 
RUN sed -i 's|^db_host=localhost|db_host=postgresdb|g' "${dadir}/install.properties"
RUN sed -i 's|^audit_solr_urls=|audit_solr_urls=http://localhost:6083/solr/ranger_audits|g' install.properties
RUN sed -i 's|^rangerAdmin_password=|rangerAdmin_password=Admin999|g' "${dadir}/install.properties"
RUN sed -i 's|^rangerTagsync_password=|rangerTagsync_password=Admin999|g' "${dadir}/install.properties"
RUN sed -i 's|^rangerUsersync_password=|rangerUsersync_password=Admin999|g' "${dadir}/install.properties"
RUN sed -i 's|^keyadmin_password=|keyadmin_password=Admin999|g' "${dadir}/install.properties"

RUN cat "${dadir}/install.properties"
# This cannot run unless mysql is active - so must be local, or must be done as 
# part of the startup if using docker-compose
#RUN JAVA_HOME=/usr/lib/jvm/default-java /opt/ranger-1.0.0-SNAPSHOT-admin/setup.sh

# Still to do
# Configure solr here.... need parameters

# Continue

# Expose web ports
EXPOSE          6080 6182 6083 6183

# Now start ranger
#CMD ["/opt/ranger-1.0.0-SNAPSHOT-admin/ranger-admin start"]
#RUN JAVA_HOME=/usr/lib/jvm/default-java /opt/ranger-1.0.0-SNAPSHOT-admin/setup.sh

# Build launch script which can be started from docker-compose
# TODO - this could be moved to a dist. script

RUN echo "#/bin/sh" > /opt/ranger-3.0.0-SNAPSHOT-admin/ranger-docker-start.sh
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64"  >> /opt/ranger-3.0.0-SNAPSHOT-admin/ranger-docker-start.sh
RUN echo "export PATH=${JAVA_HOME}:$PATH"  >> /opt/ranger-3.0.0-SNAPSHOT-admin/ranger-docker-start.sh
RUN echo "/usr/local/bin/dockerize -wait tcp://postgresdb:5432 -timeout 120s" >> /opt/ranger-3.0.0-SNAPSHOT-admin/ranger-docker-start.sh
RUN echo "/usr/bin/python3 /opt/ranger-3.0.0-SNAPSHOT-admin/dba_script.py -q" >> /opt/ranger-3.0.0-SNAPSHOT-admin/ranger-docker-start.sh
RUN echo "/opt/ranger-3.0.0-SNAPSHOT-admin/setup.sh" >> /opt/ranger-3.0.0-SNAPSHOT-admin/ranger-docker-start.sh

# Now let's start solr 
RUN echo "/opt/solr/ranger_audit_server/scripts/start_solr.sh &" >> /opt/ranger-3.0.0-SNAPSHOT-admin/ranger-docker-start.sh

RUN echo "/usr/bin/ranger-admin start" >> /opt/ranger-3.0.0-SNAPSHOT-admin/ranger-docker-start.sh
RUN chmod +x /opt/ranger-3.0.0-SNAPSHOT-admin/ranger-docker-start.sh
RUN echo "while [ true ]" >> /opt/ranger-3.0.0-SNAPSHOT-admin/ranger-docker-start.sh
RUN echo "do"  >> /opt/ranger-3.0.0-SNAPSHOT-admin/ranger-docker-start.sh
RUN echo "  sleep 10000"  >> /opt/ranger-3.0.0-SNAPSHOT-admin/ranger-docker-start.sh
RUN echo "done"  >> /opt/ranger-3.0.0-SNAPSHOT-admin/ranger-docker-start.sh

# Remove ranger build
RUN rm -rf /root/ranger
RUN rm -rf /root/apache-maven-3.8.6-bin.tar.gz


# Hopefully running that script will finish the configuration (which needs mysql)
ENTRYPOINT ["/bin/sh","-c","/opt/ranger-3.0.0-SNAPSHOT-admin/ranger-docker-start.sh"]
