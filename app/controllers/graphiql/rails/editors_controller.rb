module GraphiQL
  module Rails
    class EditorsController < ActionController::Base
      def show
      end

      helper_method :graphql_endpoint_path
      def graphql_endpoint_path
        params[:graphql_path] || raise(%|You must include `graphql_path: "/my/endpoint"` when mounting GraphiQL::Rails::Engine|)
      end

      helper_method :graphql_endpoint_method
      def graphql_endpoint_method
        params[:graphql_method] || "POST"
      end
    end
  end
end
