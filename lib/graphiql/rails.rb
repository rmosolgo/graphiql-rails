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
    class Config
      attr_accessor :query_params, :initial_query, :headers

      def initialize(query_params:, initial_query:, headers:)
        @query_params = query_params
        @initial_query = initial_query
        @headers = headers
      end

      def csrf=(active)
        if active
          ActiveSupport::Deprecation.warn(%|

csrf option has been deprecated and the X-CSRF-Token header is now sent by default.

Please remove the following line from you initializer:

  GraphiQL::Rails.config = true

|)
        else
          ActiveSupport::Deprecation.warn(%|

csrf option has been deprecated and the X-CSRF-Token header is now sent by default.

You must now delete the X-CSRF-Token header explicitly:

  GraphiQL::Rails.config.headers.delete('X-CSRF-Token')

|)
        end
      end
    end

    class << self
      attr_accessor :config
    end

    self.config = Config.new(
      query_params: false,
      initial_query: GraphiQL::Rails::WELCOME_MESSAGE,
      headers: {
        'Content-Type' => ->(_) { 'application/json' },
        'X-CSRF-Token' => ->(context) { context.form_authenticity_token }
      }
    )

    def self.resolve_headers(context)
      config.headers.each_with_object({}) do |(key, value), memo|
        memo[key] = value.call(context)
      end
    end
  end
end
