class MoviesController < ApplicationController

  def index
    @movies = Movie.all
    # @movies = @movies.where(title: params[:query]) if params[:query].present?
    # @movies = @movies.where("title iLIKE ?", "%#{params[:query]}%") if params[:query].present?
    # @movies = @movies.where("title iLIKE ? OR synopsis iLIKE ?", "%#{params[:query]}%", "%#{params[:query]}%") if params[:query].present?
    
    # sql_query = "\
    #   title iLIKE :query \
    #   OR synopsis iLIKE :query \
    #   OR directors.first_name iLIKE :query \
    #   OR directors.last_name iLIKE :query
    # "

    sql_query = "\
      title @@ :query \
      OR synopsis @@ :query \
      OR directors.first_name @@ :query \
      OR directors.last_name @@ :query
    "

    @movies = @movies.joins(:director).where(sql_query, query: "%#{params[:query]}%")

  end
end
