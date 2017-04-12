desc "Download GeoLite2 City"
task :geoip do
  sh "mkdir -p maxminddb; curl -s http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz -o maxminddb/GeoLite2-City.mmdb.gz"
  sh "gzip -d maxminddb/GeoLite2-City.mmdb.gz"
end
