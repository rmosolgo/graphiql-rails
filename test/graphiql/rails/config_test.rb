require "test_helper"

class ConfigTest < ActiveSupport::TestCase
  class MockViewContext
    attr_accessor :customer_header_value

    def form_authenticity_token
      "abc-123"
    end
  end

  setup do
    @config = GraphiQL::Rails::Config.new
    @config.headers["X-Custom-Header"] = ->(view_context) { view_context.customer_header_value }
    @view_context = MockViewContext.new
  end

  test "it adds CSRF header if requested" do
    assert_equal "abc-123", @config.resolve_headers(@view_context)["X-CSRF-Token"]
    @config.csrf = false
    assert_nil @config.resolve_headers(@view_context)["X-CSRF-Token"]
  end

  test "it adds JSON header by default" do
    assert_equal "application/json", @config.resolve_headers(@view_context)["Content-Type"]
  end

  test "when the customer header value is nil it is not added" do
    @view_context.customer_header_value = nil
    assert_equal @config.resolve_headers(@view_context).has_key?("X-Custom-Header"), false
  end

  test "when the customer header value is not nil it is added" do
    @view_context.customer_header_value = "some-value"
    assert_equal "some-value", @config.resolve_headers(@view_context)["X-Custom-Header"]
  end
end
