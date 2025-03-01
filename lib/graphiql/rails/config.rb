module GraphiQL
  module Rails
    class Config
      # @example Adding a header to the request
      #    config.headers["My-Header"] = -> (view_context) { "My-Value" }
      #
      # @return [Hash<String => Proc>] Keys are headers to include in GraphQL requests, values are `->(view_context) { ... }` procs to determin values
      attr_accessor :headers

      attr_accessor :query_params, :initial_query, :csrf, :title, :logo, :header_editor_enabled, :input_value_deprecation, :should_persist_headers

      DEFAULT_HEADERS = {
        'Content-Type' => ->(_) { 'application/json' },
      }

      CSRF_TOKEN_HEADER = {
        "X-CSRF-Token" => -> (view_context) { view_context.form_authenticity_token }
      }

      def initialize(query_params: false, initial_query: nil, title: nil, logo: nil, csrf: true, headers: DEFAULT_HEADERS, input_value_deprecation: false)
        @query_params = query_params
        @headers = headers.dup
        @initial_query = initial_query
        @title = title
        @logo = logo
        @csrf = csrf
        @input_value_deprecation = input_value_deprecation
      end

      # Call defined procs, add CSRF token if specified
      def resolve_headers(view_context)
        all_headers = DEFAULT_HEADERS.merge(headers)

        if csrf
          all_headers = all_headers.merge(CSRF_TOKEN_HEADER)
        end

        all_headers.each_with_object({}) do |(key, value), memo|
          header_value = value.call(view_context)
          memo[key] = header_value if !header_value.nil?
        end
      end
    end
  end
end
