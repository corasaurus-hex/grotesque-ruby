# -*- encoding: utf-8 -*-
require File.expand_path('../lib/grotesque/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Cora Sutton"]
  gem.email         = ["nate@zencoder.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

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
