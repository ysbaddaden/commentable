class PostsController < ApplicationController
  respond_to :html

  def index
    @posts = Post.all
    respond_with(@posts)
  end

  def show
    @post = Post.find(params[:id])
    respond_with(@post)
  end
end
