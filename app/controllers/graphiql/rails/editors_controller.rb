module GraphiQL
  module Rails
    class EditorsController < ActionController::Base
      def show
      end

      helper_method :graphql_endpoint_path
      def graphql_endpoint_path
        params[:graphql_path] || raise(%|You must include `graphql_path: "/my/endpoint"` when mounting GraphiQL::Rails::Engine|)
      end


      helper_method :local_storage_namespace
      def local_storage_namespace
        params[:local_storage_namespace]
      end

      helper_method :initial_query
      def initial_query
        params[:initial_query] || GraphiQL::Rails.config.initial_query
      end
    end
  end
end
