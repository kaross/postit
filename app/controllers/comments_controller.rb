class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    @comment.post = @post

    if @comment.save
      redirect_to @post, notice: "Comment Added!"
    else
      render 'posts/show'
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end

end