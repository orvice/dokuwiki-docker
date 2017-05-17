FROM orvice/apache-base
MAINTAINER orvice <orvice@orx.me>

# set version
ENV DOKUWIKI_VERSION 2017-02-19b
ENV DOKUWIKI_CSUM ea11e4046319710a2bc6fdf58b5cda86

RUN \
  apt-get update && \
  apt-get install -y wget && \
  rm -rf /var/lib/apt/lists/*  


# Download & check & deploy dokuwiki & cleanup
RUN wget -q -O /var/www/html/public/dokuwiki.tgz "http://download.dokuwiki.org/src/dokuwiki/dokuwiki-$DOKUWIKI_VERSION.tgz" && \
    if [ "$DOKUWIKI_CSUM" != "$(md5sum /var/www/html/public/dokuwiki.tgz | awk '{print($1)}')" ];then echo "Wrong md5sum of downloaded file!"; exit 1; fi && \
    mkdir -p /var/www/html/public && \
    tar -zxf dokuwiki.tgz -C /var/www/html/public --strip-components 1 && \
    rm dokuwiki.tgz
 

