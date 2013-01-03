Gem::Specification.new do |s|
  s.name        = 'ipcad2squid'
  s.version     = '1.3'
  s.date        = '2013-01-03'
  s.summary     = "Convert ipcad logs to squid logs"
  s.description = "Simple gem for converting and appending output from ipcad to squid logs formats"
  s.authors     = ["drakmail", "xPadla"]
  s.email       = 'drakmail@delta.pm'

  s.files         = `git ls-files`.split($\)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.homepage    = 'https://github.com/drakmail/ipcad2squid'

  s.add_development_dependency 'rspec'
end
