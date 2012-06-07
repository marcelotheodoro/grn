# -*- encoding: utf-8 -*-
require File.expand_path('../lib/grn/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Marcelo"]
  gem.email         = ["marcelo.theodorojr@gmail.com"]
  gem.description   = "Implementa os conceitos da linguagem de padrões GRN"
  gem.summary       = "Implementa classes de apoio para a linguagem de padrões GRN e cria geradores para cada padrão"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "grn"
  gem.require_paths = ["lib"]
  gem.version       = Grn::VERSION
end
