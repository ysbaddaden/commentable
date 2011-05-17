module Commentable
  class Controller < ApplicationController
    before_filter :load_commentable

    def index
      @comment = @commentable.comments.all
      respond_with(@commentable, @comments)
    end

    def show
      @comment = @commentable.comments.find(params[:id])
      respond_with(@commentable, @comment)
    end

    def new
      @comment = build_comment
      respond_with(@commentable, @comment)
    end

    def edit
      @comment = @commentable.comments.find(params[:id])
    end

    def create
      @comment = build_comment(params[:comment])
      @comment.save
      respond_with(@commentable, @comment,
        :location => { :action => "show", :id => @comment.to_param })
    end

    def update
      @comment = @commentable.comments.find(params[:id])
      @comment.update_attributes(params[:comment])
      respond_with(@commentable, @comment, :location => { :action => "show" })
    end

    def destroy
      @comment = @commentable.comments.find(params[:id])
      @comment.destroy
      respond_with(@commentable, @comment, :location => @commentable)
    end

    def build_comment(params = nil)
      @commentable.comments.build(params)
    end

    def load_commentable
      id = params["#{params[:commentable]}_id"]
      @commentable = params[:commentable].camelize.constantize.find(id)
    end
  end
end
