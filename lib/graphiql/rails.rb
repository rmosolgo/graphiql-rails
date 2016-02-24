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

require "graphiql/rails/engine"
require "graphiql/rails/version"
require "graphiql/rails/welcome_message"


module GraphiQL
  module Rails
    class << self
      attr_accessor :config
    end

    self.config = OpenStruct.new({
      query_params: false,
      initial_query: GraphiQL::Rails::WELCOME_MESSAGE,
      csrf: false
    })
  end
end
