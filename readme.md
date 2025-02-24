# GraphiQL-Rails [![Gem Version](https://badge.fury.io/rb/graphiql-rails.svg)](https://badge.fury.io/rb/graphiql-rails) [![Tests](https://github.com/rmosolgo/graphiql-rails/actions/workflows/test.yml/badge.svg)](https://github.com/rmosolgo/graphiql-rails/actions/workflows/test.yml)

Mount the [GraphiQL IDE](https://github.com/graphql/graphiql) in Ruby on Rails.

![image](https://cloud.githubusercontent.com/assets/2231765/12101544/4779ed54-b303-11e5-918e-9f3d3e283170.png)

## Installation

Add to your Gemfile:

```ruby
bundle add graphiql-rails
```

Additionally, you'll need [Sprockets or Propshaft](#sprockets-or-propshaft) to serve the JS and CSS assets.

## Usage

### Mount the Engine

Add the engine to `routes.rb`:

```ruby
# config/routes.rb
Rails.application.routes.draw do
  # ...
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/your/endpoint"
  end
end
```

- `at:` is the path where GraphiQL will be served. You can access GraphiQL by visiting that path in your app.
- `graphql_path:` is the path to the GraphQL endpoint. GraphiQL will send queries to this path.

### Sprockets or Propshaft

You're probably using [Sprockets](https://github.com/rails/sprockets) or [Propshaft](https://github.com/rails/propshaft) to deliver the JS and CSS for GraphiQL. If you don't already have one of those, you can add them with:

```sh
$ bundle add sprockets-rails
# or
$ bundle add propshaft
```

As a fallback, GraphiQL Rails will serve assets using a Rack Middleware.

### Configuration

You can override `GraphiQL::Rails.config` values in an initializer (eg, `config/initializers/graphiql.rb`). The configs are:

- `query_params` (boolean, default `false`): if `true`, the GraphQL query string will be persisted the page's query params
- `initial_query` (string, default `nil`): if provided, it will be rendered in the query pane for a visitor's first visit
- `title` (string, default `nil`): if provided, it will be rendered in the page <title> tag
- `logo` (string, default `nil`): if provided, it will be the text logo
- `csrf` (boolean, default `true`): include `X-CSRF-Token` in GraphiQL's HTTP requests
- `header_editor_enabled` (boolean, default `false`): if provided, the header editor will be rendered
- `headers` (hash, `String => Proc`): procs to fetch header values for GraphiQL's HTTP requests, in the form `(view_context) -> { ... }`. For example:

    ```ruby
    GraphiQL::Rails.config.headers['Authorization'] = -> (context) { "bearer #{context.cookies['_graphql_token']}" }
    ```

- `input_value_deprecation` (boolean, default `false`): if provided, the deprecated arguments will be rendered
- `should_persist_headers` (boolean, default `nil`): if `true`, the headers in the editor will be persisted. If `false`, the toggle for 'Persist headers' will not be shown in the settings

### Development

- Tests: `rake test`
- Update GraphiQL & dependencies: `rake update_graphiql`
