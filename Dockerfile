#
# Nasqueron - Pixelfed image
#

FROM nasqueron/nginx-php7-fpm:novolume
MAINTAINER Sébastien Santoro aka Dereckson <dereckson+nasqueron-docker@espace-win.org>

#
# Prepare the container
#

COPY files /

WORKDIR /var/wwwroot/default

RUN apt-get update && apt-get install -y --no-install-recommends \
	optipng pngquant jpegoptim gifsicle && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    git init && git remote add origin https://github.com/pixelfed/pixelfed.git && \
    git fetch && git checkout -t origin/dev && \
    composer install --no-dev -o && \
    chown -R app:app /var/wwwroot/default

#
# Run the container
#

CMD ["/usr/local/sbin/init-container"]
