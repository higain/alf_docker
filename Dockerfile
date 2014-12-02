######################################################################
# Dockerfile
# Author: Matt Ward
# Date:   28 December 2014
#
# An Alfresco Repository, Solr and Share all-in-one image prototype.
# NOT FOR PRODUCTION USE!
######################################################################

FROM ubuntu:14.04

MAINTAINER Matt Ward <matt.ward@alfresco.com>

ENV ALF_VER 4.2.5
ENV ALF_INSTALLER_BIN alfresco-enterprise-${ALF_VER}-installer-linux-x64.bin
ENV ALF_INSTALLER_DIR /alfresco/installer
ENV ALFRESCO_HOME /opt/alfresco-${ALF_VER}
ENV ALF_PROPS_FILE $ALFRESCO_HOME/tomcat/shared/classes/alfresco-global.properties
RUN apt-get update
RUN apt-get install -y libxext6 libc6 libfreetype6 libx11-6 libxau6 libxdmcp6 libxinerama1 libcups2 libdbus-glib-1-2 libfontconfig1
RUN mkdir -p $ALF_INSTALLER_DIR
ADD $ALF_INSTALLER_BIN $ALF_INSTALLER_DIR/
WORKDIR $ALF_INSTALLER_DIR
RUN chmod +x $ALF_INSTALLER_BIN
RUN ./$ALF_INSTALLER_BIN --mode unattended --alfresco_admin_password admin

# We'd see problems if running multiple instances and those instances
# aren't aware of what these ports have been mapped to on the host.
# For example, if a page in Share spawns an Edit Online session, it will expect
# 7070 to be accessible on the outside world.
EXPOSE 8080 7070

WORKDIR $ALFRESCO_HOME

# Fix properties in alfresco-global.properties
# If we run with externally mapped port other than 8080, then that would need to be
# dealt with as well.
### This actually should be done at runtime, not build and should be done in alfresco.sh
### and should use $(hostname) perhaps, in place of docker-host
RUN sed -i 's:^[ \t]*alfresco.host[ \t]*=\([ \t]*.*\)$:alfresco.host='docker-host':' $ALF_PROPS_FILE
RUN sed -i 's:^[ \t]*share.host[ \t]*=\([ \t]*.*\)$:share.host='docker-host':' $ALF_PROPS_FILE


# Ensure a log file exists ready for tail
RUN touch $ALFRESCO_HOME/alfresco.log

# Install a license file if one exists
ADD *.lic $ALFRESCO_HOME/tomcat/shared/classes/alfresco/extension/license

CMD $ALFRESCO_HOME/alfresco.sh start && tail -f $ALFRESCO_HOME/alfresco.log
