module OmniRegion
  class CitiesController < ApplicationController
    def index
      @q = City.ransack(params[:q])
      @cities = @q.result.page(params[:page]).per(params[:per] || 10)
    end
  end
end
