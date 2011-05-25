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
    (1..4).each { Comment.create!(:commentable => posts(:two), :body => "lorem ipsum", :user_ip => "127.0.0.1", :spam => true) }
    assert !Comment.new(:commentable => posts(:one), :body => "lorem ipsum", :user_ip => "127.0.0.1").valid?
  end

  test "spam quota time lapse" do
    (1..4).each { Comment.create!(:commentable => posts(:one), :body => "lorem ipsum", :user_ip => "127.0.0.1", :spam => true, :created_at => 2.days.ago) }
    assert Comment.new(:commentable => posts(:one), :body => "lorem ipsum", :user_ip => "127.0.0.1").valid?
  end

  test "troll quota" do
    (1..4).each { Comment.create!(:commentable => posts(:two), :body => "lorem ipsum", :user_ip => "127.0.0.1", :troll => true) }
    assert !Comment.new(:commentable => posts(:one), :body => "lorem ipsum", :user_ip => "127.0.0.1").valid?
  end

  test "troll quota time lapse" do
    (1..4).each { Comment.create!(:commentable => posts(:one), :body => "lorem ipsum", :user_ip => "127.0.0.1", :troll => true, :created_at => 2.days.ago) }
    assert Comment.new(:commentable => posts(:one), :body => "lorem ipsum", :user_ip => "127.0.0.1").valid?
  end
end
