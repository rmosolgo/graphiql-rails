require "test_helper"

module GraphiQL
  module Rails
    class EditorsControllerTest < ActionController::TestCase
      setup do
        @routes = GraphiQL::Rails::Engine.routes
      end

      teardown do
        GraphiQL::Rails.config.query_params = false
        GraphiQL::Rails.config.initial_query = nil
        GraphiQL::Rails.config.title = nil
        GraphiQL::Rails.config.logo = nil
        GraphiQL::Rails.config.headers = {}
      end

      def graphql_params
        { params: { graphql_path: "/my/endpoint" } }
      end

      test "renders GraphiQL" do
        get :show, graphql_params
        assert_response(:success)
        assert_includes(@response.body, "React.createElement(GraphiQL", "it renders GraphiQL")
        assert_includes(@response.body, "my/endpoint", "it uses the provided path")
        assert_match(/application-\w+\.js/, @response.body, "it includes assets")
      end

      test "it uses initial_query config" do
        GraphiQL::Rails.config.initial_query = '{ customQuery(id: "123") }'
        get :show, graphql_params
        assert_includes(@response.body, '"{ customQuery(id: \"123\") }"')

        GraphiQL::Rails.config.initial_query = nil
        get :show, graphql_params
        refute_includes(@response.body, '"{ customQuery(id: \"123\") }"')
      end

      test "it uses title config" do
        GraphiQL::Rails.config.title = 'Custom Title'
        get :show, graphql_params
        assert_includes(@response.body, '<title>Custom Title</title>')

        GraphiQL::Rails.config.title = nil
        get :show, graphql_params
        assert_includes(@response.body, '<title>GraphiQL</title>')
      end

      test "it uses logo config" do
        GraphiQL::Rails.config.logo = 'Custom Logo'
        get :show, graphql_params
        assert_includes(@response.body, 'React.createElement(GraphiQL.Logo, {}, "Custom Logo")')

        GraphiQL::Rails.config.logo = nil
        get :show, graphql_params
        refute_includes(@response.body, 'React.createElement(GraphiQL.Logo, {}, "Custom Logo")')
      end

      test "it uses query_params config" do
        get :show, graphql_params
        refute_includes(@response.body, "onEditQuery")

        GraphiQL::Rails.config.query_params = true
        get :show, graphql_params
        assert_includes(@response.body, "onEditQuery")
      end

      test "it renders headers" do
        GraphiQL::Rails.config.headers["Nonsense-Header"] = -> (view_ctx) { "Value" }
        get :show, graphql_params
        assert_includes(@response.body, %|"Nonsense-Header": "Value"|)
        assert_includes(@response.body, %|"X-CSRF-Token": "|)
      end
    end
  end
end
