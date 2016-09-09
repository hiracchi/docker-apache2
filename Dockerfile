FROM hiracchi/ubuntu-ja-supervisor
MAINTAINER Toshiyuki HIRANO <hiracchi@gmail.com>

# packages install 
RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#
#RUN mkdir -p /work /work/sites-available /work/sites-enabled /work/html
#RUN cp /etc/apache2/sites-available/* /work/sites-available/
#RUN cp /etc/apache2/sites-enabled/* /work/sites-enabled/
#RUN cp /var/www/html/* /work/html
#RUN ln -snf /work/sites-available /etc/apache2/sites-available && \
#    ln -snf /work/sites-enabled /etc/apache2/sites-enabled && \
#    ln -snf /work/html /var/www/html

RUN /usr/sbin/a2ensite default-ssl
RUN /usr/sbin/a2enmod ssl

# for service
COPY supervisor.apache.conf /etc/supervisor/conf.d/apache.conf

EXPOSE 80 443
ENTRYPOINT ["/usr/bin/supervisord"]

