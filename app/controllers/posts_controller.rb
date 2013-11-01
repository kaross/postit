class PostsController < ApplicationController
  before_action :set_post, only: [:show, :vote, :edit, :update]
  before_action :require_user, except: [:index, :show]

  def index
    @posts = Post.all.sort_by {|x| total_votes(x)}.reverse 
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

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
    require_admin unless update_access(@post)

    if @post.update(post_params)
      redirect_to @post, notice: 'Post was updated!'
    else
      render 'edit'
    end
  end

  def edit
    require_admin unless update_access(@post)
  end

  def show
    @comment = Comment.new
  end

  def vote
    @vote = Vote.new(vote: params[:vote], voteable: @post, creator: current_user)

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
    def set_post
      @post = Post.find_by(slug: params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :url, :description, category_ids: [])
    end
end
