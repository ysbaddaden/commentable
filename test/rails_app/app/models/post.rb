class Post < ActiveRecord::Base
  has_many :comments, :as => :commentable, :order => :created_at
end
