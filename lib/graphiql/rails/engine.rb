module GraphiQL
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace GraphiQL::Rails
    end
  end
end
