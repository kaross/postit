class CommentsController < ApplicationController
  before_action :require_user

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find_by(slug: params[:post_id])
    @comment.post = @post
    @comment.creator = current_user

    if @comment.save
      redirect_to @post, notice: "Comment Added!"
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.new(vote: params[:vote], voteable: @comment, creator: current_user)

    respond_to do |format|
      if @vote.save
        format.html { redirect_to :back, notice: 'Vote was counted!' }
        format.js
      else
        format.html do 
          flash[:error] = @vote.errors[:creator].first
          redirect_to :back
        end
        format.js 
      end
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end

end
