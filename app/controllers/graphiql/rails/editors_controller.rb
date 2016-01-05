module GraphiQL
  module Rails
    class EditorsController < ActionController::Base
      def show
      end

      helper_method :graphql_endpoint_path
      def graphql_endpoint_path
        params[:graphql_path] || raise(%|You must include `graphql_path: "/my/endpoint"` when mounting GraphiQL::Rails::Engine|)
      end
    end
  end
end
