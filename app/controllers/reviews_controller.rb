class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_post, except: [:index]


  def index
    @review = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @page_title = 'Add Review'
    @review = Review.new
   end

  def edit
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.post_id = @post.id
    @review.reviewee_id = @post.user_id
    if @review.save
        flash[:notice] = "Review Created"
        redirect_to @post
    else
        flash[:alert] = "Review Not Created"
        render 'new'
    end
  end

  def update
    if @review.update(review_params)
          flash[:notice] = "Review Updated"
          redirect_to root_path
      else
          flash[:alert] = "Review Not Updated"
          render :action => 'edit'
      end
  end
  private

  def set_review
    @review = Review.find(params[:id]) 
  end 
  
  def set_post
    @post = Post.find(params[:post_id])
  end

   def review_params
      params 
      .require(:review)
      .permit(:title, :description, :rating, :post_id)
  end
 
end
