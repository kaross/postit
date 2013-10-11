class PostsController < ApplicationController
  before_action :set_post, only: [:update, :edit, :show]

  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was created!'
    else
      render 'new'
    end
  end

  def new
    @post = Post.new
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was updated!'
    else
      render 'edit'
    end
  end

  def edit

  end

  def show
    @comment = Comment.new
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :url, :description, category_ids: [])
    end

end
