module Commentable
  class Controller < ApplicationController
    before_filter :load_commentable

    def index
      @comments = @commentable.comments.all
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
      
      respond_with(@commentable, @comment) do |format|
        format.html do
          if @comment.persisted?
            redirect_to comment_url
          else
            render 'new'
          end
        end
      end
    end

    def update
      @comment = @commentable.comments.find(params[:id])
      @comment.update_attributes(params[:comment])
      respond_with(@commentable, @comment, :location => comment_url)
    end

    def destroy
      @comment = @commentable.comments.find(params[:id])
      @comment.destroy
      respond_with(@commentable, @comment, :location => commentable_url)
    end

    def comment_url
      polymorphic_url(@commentable, :anchor => "C#{@comment.to_param}")
    end

    def commentable_url
      @commentable
    end

    def build_comment(params = nil)
      comment = @commentable.comments.build(params)
      comment.user_ip = request.remote_ip if comment.respond_to?(:user_ip)
      comment
    end

    def load_commentable
      id = params["#{params[:commentable]}_id"]
      @commentable = params[:commentable].camelize.constantize.find(id)
    end
  end
end
