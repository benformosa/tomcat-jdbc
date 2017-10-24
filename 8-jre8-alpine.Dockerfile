FROM tomcat:8-jre8-alpine

RUN  apk update \
  && apk add --no-cache \
     perl-text-template

# Copy tomcat manager application configuration
COPY docker/manager.xml conf/Catalina/localhost/

# Copy configuration and run scripts
COPY ["docker/*.p[lm]", "docker/*.template", "docker/run.sh", "/usr/local/bin/"]

CMD ["run.sh"]

# Copy JARs and WARs
ONBUILD COPY lib/*.jar lib/
ONBUILD ADD *.war webapps/