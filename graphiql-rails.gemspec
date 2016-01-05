$LOAD_PATH.push File.expand_path("../lib", __FILE__)

require "graphiql/rails/version"

Gem::Specification.new do |s|
  s.name        = 'graphiql-rails'
  s.version     = GraphiQL::Rails::VERSION
  s.date        = Date.today.to_s
  s.summary     = "A mountable GraphiQL endpoint for Rails"
  s.description = "Use the GraphiQL IDE for GraphQL with Ruby on Rails. This gem includes an engine, a controller and a view for integrating GraphiQL with your app."
  s.homepage    = 'http://github.com/rmosolgo/graphiql-rails'
  s.authors     = ["Robert Mosolgo"]
  s.email       = ['rdmosolgo@gmail.com']
  s.license     = "MIT"
  s.required_ruby_version = '>= 2.1.0' # bc optional keyword args

  s.files = Dir["{app,config,lib}/**/*", "MIT-LICENSE", "readme.md"]
  s.test_files = Dir["test/**/*"]

  s.add_runtime_dependency "rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "codeclimate-test-reporter", '~>0.4'
  s.add_development_dependency "minitest", "~> 5"
  s.add_development_dependency "minitest-focus", "~> 1.1"
  s.add_development_dependency "minitest-reporters", "~>1.0"
  s.add_development_dependency "rake", "~> 10.4"
end
