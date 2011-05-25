require File.expand_path('../commentable/model.rb', __FILE__)

module Commentable
  autoload :Controller, File.expand_path('../commentable/controller.rb', __FILE__)
  autoload :Model,      File.expand_path('../commentable/model.rb', __FILE__)
end

