class PostsController < ApplicationController
  
  before_action :set_post, only: [:show, :edit, :update, :destroy, :connect]
  before_action :authenticate_user!, except: [:index, :show]

  respond_to :html, :js

  def index
    @posts = Post.all.order('created_at DESC')
  end

  def show
    @reviews = Review.where(post_id: @post.id).order('created_at DESC')
    #if @reviews.blank?
     # @reviews = 0
    #else
    #  @avg_review = @reviews.average(:rating).round(2)
    #end  
  end

  def new
    #@post = current_user.posts.build  
    @post = current_user.posts.build(post_params)
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)

    #@post = Post.new(post_params)
    @post.user_id = current_user.id
    # Save the post
    if @post.save
      flash[:notice] = 'Post Created'
      redirect_to posts_path
    else
      render 'new'
    end
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

    def post_params
      params.require(:post).permit(:title, :description, :image, :price)
    end
 
end
