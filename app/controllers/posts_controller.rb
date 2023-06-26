class PostsController < ApplicationController
  before_action :require_login, only: [:new, :create]
  
  def index
    @posts = Post.all

    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
    end
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:notice] = "Post created successfully!"
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login
    unless logged_in?
      flash[:alert] = "You must be logged in to access this section"
      redirect_to sign_in_path
    end
  end

  def logged_in?
    true unless session[:user_id].nil?
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
