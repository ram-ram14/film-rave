class ReviewsController < ApplicationController

  # Index action to retrieve all reviews
  def index
    @reviews = Review.all
  end

  # Show action to retrieve a single review by id
  def show
    @review = Review.find(params[:id])
    @movie = Movie.find(@review.movie_id)
  end

  # New action to create a new review object
  def new
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.build
  end

  # Create action to save a new review object to the database
  def create
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.build(review_params)
    if @review.save
      redirect_to movie_path(@movie), notice: 'Review was successfully created.'
    else
      render :new
    end
  end  

  # Edit action to retrieve an existing review object for editing
  def edit
    @review = Review.find(params[:id])
  end

  # Update action to save changes made to an existing review object
  def update
    @review = Review.find(params[:id])

    if @review.update(review_params)
      redirect_to @review
    else
      render :edit
    end
  end

  # Destroy action to remove a review object from the database
  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    redirect_to reviews_path
  end

  private

  # Review params method to whitelist incoming review data
  def review_params
    params.require(:review).permit(:title, :body, :rating, :movie_id)
  end
end
