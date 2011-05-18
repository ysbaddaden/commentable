require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:one)
  end

  test "should get index (xml)" do
    get :index, :post_id => @post.to_param, :commentable => 'post', :format => "xml"
    assert_response :ok
    assert_select "comment", @post.comments.count
  end

  test "should get show (xml)" do
    get :show, :post_id => @post.to_param, :commentable => 'post',
      :id => comments(:post_one_1).to_param, :format => "xml"
    assert_response :ok
    assert_select "comment", 1
  end

  test "should get new" do
    get :new, :post_id => @post.to_param, :commentable => 'post'
    assert_response :ok
  end

  test "should get edit" do
    get :edit, :post_id => @post.to_param, :commentable => 'post',
      :id => comments(:post_one_1).to_param
    assert_response :ok
  end

  test "should create" do
    assert_difference('Comment.count') do
      post :create, :post_id => @post.to_param, :commentable => 'post',
        :comment => { :body => "lorem ipsum dolor sit amet" }
      assert_redirected_to post_url(@post, :anchor => "C#{assigns(:comment).to_param}")
    end
    
    assert_not_nil assigns(:comment).user_ip
  end

  test "should not create" do
    assert_no_difference('Comment.count') do
      post :create, :post_id => @post.to_param, :commentable => 'post',
        :comment => { :body => "   " }
      assert_response :ok
      assert_template "comments/new"
    end
  end

  test "should update" do
    put :update, :post_id => @post.to_param, :commentable => 'post',
      :id => comments(:post_one_1).to_param, :comment => { :body => "lorem ipsum dolor sit amet" }
    assert_redirected_to post_url(@post, :anchor => "C#{assigns(:comment).to_param}")
    assert_equal "lorem ipsum dolor sit amet", comments(:post_one_1).reload.body
  end

  test "should not update" do
    put :update, :post_id => @post.to_param, :commentable => 'post',
      :id => comments(:post_one_1).to_param, :comment => { :body => " " }
    assert_response :ok
    assert_template "comments/edit"
    assert_not_equal " ", comments(:post_one_1).reload.body
  end

  test "should destroy" do
    assert_difference('Comment.count', -1) do
      delete :destroy, :post_id => @post.to_param, :commentable => 'post',
        :id => comments(:post_one_1).to_param
      assert_redirected_to @post
    end
  end
end
