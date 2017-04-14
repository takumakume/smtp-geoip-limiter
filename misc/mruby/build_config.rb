MRuby::Build.new do |conf|
  toolchain :gcc

  conf.gembox 'full-core'

  conf.gem :github => 'iij/mruby-io'
  conf.gem :github => 'iij/mruby-env'
  conf.gem :github => 'iij/mruby-dir'
  #conf.gem :github => 'iij/mruby-digest'
  #conf.gem :github => 'iij/mruby-process'
  #conf.gem :github => 'iij/mruby-pack'
  #conf.gem :github => 'iij/mruby-socket'
  #conf.gem :github => 'matsumoto-r/mruby-sleep'
  #conf.gem :github => 'matsumoto-r/mruby-userdata'
  #conf.gem :github => 'matsumoto-r/mruby-uname'
  #conf.gem :github => 'matsumoto-r/mruby-mutex'
  #conf.gem :github => 'matsumoto-r/mruby-localmemcache'
  conf.gem :github => 'AndrewBelt/mruby-yaml'
  conf.gem :github => 'kaihar4-archive/mruby-ipaddress_matcher'

  conf.gem :github => 'iij/mruby-mtest'
end
