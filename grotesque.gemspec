# -*- encoding: utf-8 -*-
require File.expand_path('../lib/grotesque/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Cora Sutton"]
  gem.email         = ["nathan.sutton@gmail.com"]
  gem.description   = %q{Use ZooKeeper like Redis. A grotesque.}
  gem.summary       = %q{A library that makes is possible to use ZooKeeper like Redis. A grotesque.}

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "grotesque"
  gem.require_paths = ["lib"]
  gem.version       = Grotesque::VERSION
  gem.add_dependency "zk"
  gem.add_dependency "msgpack-rpc"
  gem.add_development_dependency "rspec"
end
