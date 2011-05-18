require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "should validate body" do
    assert Comment.create.errors[:body].any?
  end

  test "should be valid" do
    assert Comment.new(:body => "lorm ipsum").valid?
  end
end
