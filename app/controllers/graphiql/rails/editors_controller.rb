module GraphiQL
  module Rails
    class EditorsController < ActionController::Base
      before_action :authenticate

      def show
      end

      helper_method :graphql_endpoint_path
      def graphql_endpoint_path
        params[:graphql_path] || raise(%|You must include `graphql_path: "/my/endpoint"` when mounting GraphiQL::Rails::Engine|)
      end

      private

      def authenticate
        options = GraphiQL::Rails.config.basic_auth

        return if options.empty? || session[:graphiql_signed_in_at].present?

        session[:graphiql_signed_in_at] = Time.zone.now if authenticate_or_request_with_http_basic(options[:realm] || "Application") { |name, password|
          ActiveSupport::SecurityUtils.secure_compare(name, options[:name]) &
          ActiveSupport::SecurityUtils.secure_compare(password, options[:password])
        }
      end
    end
  end
end
