task default: :run_unit_test

desc "Build mruby container"
task :build do
  sh "docker build -t smtp-geoip-limiter:mruby ."
end

desc "Run unit test"
task :run_unit_test => [:build] do
  sh "docker run --rm -t smtp-geoip-limiter:mruby"
end

desc "Execute unit test from mruby container"
task :exec_unit_test => [:build] do
  sh "mruby src/smtp-geoip-limiter.rb"
end

desc "Container development"
task :dev => [:build] do
  sh "docker run -v `pwd`:/tmp -it smtp-geoip-limiter:mruby /bin/bash"
end

desc "Download and decompress GeoLite2 mmdb"
task :geoip do
  sh "mkdir -p maxminddb; curl -s http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz -o maxminddb/GeoLite2-City.mmdb.gz"
  sh "gzip -d maxminddb/GeoLite2-City.mmdb.gz"
end
