require "rails"

if ActiveSupport::Inflector.method(:inflections).arity == 0
  # Rails 3 does not take a language in inflections.
  ActiveSupport::Inflector.inflections do |inflect|
    inflect.acronym("GraphiQL")
  end
else
  ActiveSupport::Inflector.inflections(:en) do |inflect|
    inflect.acronym("GraphiQL")
  end
end

require "graphiql/rails/config"
require "graphiql/rails/engine"
require "graphiql/rails/version"

module GraphiQL
  module Rails
    class << self
      attr_accessor :config
    end

    self.config = Config.new
  end
end
