class PostsController < ApplicationController
  
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, except: [:index]

  respond_to :html, :js

  def index
    @posts = Post.all.order('created_at DESC')
  end

  def show
    @reviews = Review.where(post_id: @post.id).order("created_at DESC")
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.save

    respond_with @post
  end

  def update
    @post.update_attributes(params[:post])

    respond_with @post
  end

  def destroy
    @post.destroy

    redirect_to posts_path
  end

  def connect
    @buyer = Buyer.new
    @buyer.user_id = current_user.id
    @buyer.post_id = @post.id
    if @buyer.save
	@post.increment(:number_of_buyers, by = 1)	
        @post.save
	flash[:notice] = "Connection Created"
    	redirect_to posts_path
    else
        flash[:alert] = "Connection Not Created"
    end 
  end

  private 

  def set_post
    @post = Post.find(params[:id])
  end

  def posts_params
    params.require(:post).permit(:title, :description, :image)
  end
 
  
end
