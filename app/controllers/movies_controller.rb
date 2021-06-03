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

    # PG Full-text Search
    # sql_query = "\
    #   title @@ :query \
    #   OR synopsis @@ :query \
    #   OR directors.first_name @@ :query \
    #   OR directors.last_name @@ :query
    # "

    # @movies = @movies.joins(:director).where(sql_query, query: "%#{params[:query]}%")
    # @movies = @movies.search_by_title_and_synopsis(params[:query]) if params[:query].present?
    # @movies = @movies.global_search(params[:query]) if params[:query].present?
    @movies = PgSearch.multisearch(params[:query]) if params[:query].present?
  end
end
