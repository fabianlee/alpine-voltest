FROM fabianlee/alpine-apache:2.4.41-r0

# send logs to stdout/stderr
RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log

# add web content
VOLUME "/var/www/localhost/htdocs/"


