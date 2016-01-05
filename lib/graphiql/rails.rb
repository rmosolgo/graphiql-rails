require "rails"

ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.acronym("GraphiQL")
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
      initial_query: GraphiQL::Rails::WELCOME_MESSAGE
    })
  end
end
