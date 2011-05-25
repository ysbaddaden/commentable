module ActionDispatch # :nodoc:
  module Routing # :nodoc:
    class Mapper
      def commentable(options = {})
        resources :comments, options do
          put :spam, :troll, :on => :member
        end
      end
    end
  end
end
