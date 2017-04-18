FROM centos:latest

RUN yum install -y epel-release
RUN yum install -y \
  gcc \
  git \
  openssl-devel \
  ca-certificates \
  rubygems \
  curl \
  bison \
  libmaxminddb-devel \
  libyaml-devel

RUN gem install \
  mgem \
  rake

WORKDIR /var/lib
RUN curl -s http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz -o GeoLite2-City.mmdb.gz && gzip -d GeoLite2-City.mmdb.gz

WORKDIR /usr/local/src
RUN git clone --depth=1 git://github.com/mruby/mruby.git
ADD misc/mruby/build_config.rb mruby/
#RUN cd mruby && rake all && cp bin/mruby /usr/local/bin/

ADD . /tmp
WORKDIR /tmp

CMD rake exec_test
