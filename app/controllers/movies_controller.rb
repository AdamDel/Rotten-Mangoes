class MoviesController < ApplicationController

  before_filter :restrict_access, except: [:index, :show]
  def index
    @movies = Movie.query_search(params[:query]).duration_search(params[:duration])
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
    #@movie.avatar = params[:file]
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to new_session_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :avatar, :description, :query 
    )
  end

end