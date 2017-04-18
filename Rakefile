task default: :test

desc "Build mruby container"
task :build do
  sh "docker build -t smtp-geoip-limiter:mruby ."
end

desc "Run unit test"
task :test => [:build] do
  sh "docker run --rm -t smtp-geoip-limiter:mruby"
end

desc "Run container for development"
task :dev => [:build] do
  sh "docker run -v `pwd`:/tmp -it smtp-geoip-limiter:mruby /bin/bash"
end

desc "Execute unit test in container"
task :exec_test do
  sh "mruby src/smtp-geoip-limiter.rb"
end
