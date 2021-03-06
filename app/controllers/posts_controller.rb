class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy, :connect]
  before_action :authenticate_user!, except: [:index, :show]

  respond_to :html, :js

  def index
    if params[:query].present?
    	@posts = Post.search(params[:query])
    else
	@posts = Post.all.order('created_at DESC')
     end
  end
  
  def show
    @reviews = Review.where(post_id: @post.id).order('created_at DESC')
    if @reviews.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating)
    end
  end

  def new
    @post = current_user.posts.build
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
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
   @post.update(post_params)    
   # @post.update_attributes(params[:post])
   redirect_to post_path

  end

  def destroy
    if @post.destroy
      flash[:notice] = 'Post Deleted'
      redirect_to posts_path
    else
      render 'destroy'
    end

  end

  def connect
    @buyer = Buyer.new
    if @post.status == 'open' || @post.status == 'pending'
    	if Review.reviewer_is_driver?(current_user.id, @post.user_id) == false
      	    @buyer.user_id = current_user.id
            @buyer.post_id = @post.id
            if @buyer.save
                @post.increment(:number_of_buyers, by = 1)
         	@post.status = 'pending'
	        if @post.save
          	    PostStatusModifierJob.perform_later
	            flash[:notice] = "Connection Created"
                else
          	    flash[:alert] = "Connection Not Created"
                end
            else
                flash[:alert] = "Connection Not Created"
            end
         else
            flash[:alert] = "Connection Not Created"
         end
    else
        flash[:alert] = "Connection Not Created"
    end
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    # TODO fix: status should not be set here
    params.require(:post).permit(:title, :description, :image, :price, :when, :status)
  end

end
