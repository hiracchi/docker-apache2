FROM hiracchi/ubuntu-ja:latest
MAINTAINER Toshiyuki HIRANO <hiracchi@gmail.com>

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/hiracchi/docker-ubuntu-apache2" \
      org.label-schema.version=$VERSION


RUN apt-get update \
  && apt-get install -y apache2 \
  && apt-get install -y php php-cgi libapache2-mod-php php-common \
     php-pear php-mbstring php-gd php-imagick \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*


RUN /usr/sbin/a2ensite default-ssl \
  && /usr/sbin/a2enmod ssl \
  && /usr/sbin/a2enmod rewrite 


EXPOSE 80 443
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]


