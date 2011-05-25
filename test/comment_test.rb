require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "should validate body" do
    assert Comment.create.errors[:body].any?
  end

  test "should validate commentable" do
    assert Comment.create.errors[:commentable].any?
  end

  test "should be valid" do
    assert Comment.new(:commentable => posts(:one), :body => "lorem ipsum").valid?
  end

  test "spam quota" do
    Comment.create!(:commentable => posts(:one), :body => "lorem ipsum", :user_ip => "127.0.0.1", :spam => true)
    Comment.create!(:commentable => posts(:one), :body => "lorem ipsum", :user_ip => "127.0.0.1", :spam => true)
    Comment.create!(:commentable => posts(:one), :body => "lorem ipsum", :user_ip => "127.0.0.1", :spam => true)
    Comment.create!(:commentable => posts(:one), :body => "lorem ipsum", :user_ip => "127.0.0.1", :spam => true)
    
    Comment.create!(:commentable => posts(:one), :body => "lorem ipsum", :user_ip => "127.0.0.1", :spam => true)
    Comment.create!(:commentable => posts(:one), :body => "lorem ipsum", :user_ip => "127.0.0.1", :spam => true)
  end
end
