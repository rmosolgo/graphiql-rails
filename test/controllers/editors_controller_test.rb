require "test_helper"

module GraphiQL
  module Rails
    class EditorsControllerTest < ActionController::TestCase
      setup do
        @routes = GraphiQL::Rails::Engine.routes
      end

      teardown do
        GraphiQL::Rails.config.query_params = false
        GraphiQL::Rails.config.initial_query = GraphiQL::Rails::WELCOME_MESSAGE
      end

      test "renders GraphiQL" do
        get :show, graphql_path: "/my/endpoint"
        assert_response(:success)
        assert_includes(@response.body, "React.createElement(GraphiQL", "it renders GraphiQL")
        assert_includes(@response.body, "my/endpoint", "it uses the provided path")
        assert_match(/application-\w+\.js/, @response.body, "it includes assets")
      end

      test "it uses initial_query config" do
        get :show, graphql_path: "/my/endpoint"
        assert_includes(@response.body, "Welcome to GraphiQL")

        GraphiQL::Rails.config.initial_query = "{ customQuery }"
        get :show, graphql_path: "/my/endpoint"
        refute_includes(@response.body, "Welcome to GraphiQL")
        assert_includes(@response.body, "{ customQuery }")
      end

      test "it uses query_params config" do
        get :show, graphql_path: "/my/endpoint"
        refute_includes(@response.body, "onEditQuery")

        GraphiQL::Rails.config.query_params = true
        get :show, graphql_path: "/my/endpoint"
        assert_includes(@response.body, "onEditQuery")
      end
    end
  end
end
