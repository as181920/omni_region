module OmniRegion
  class DistrictsController < ApplicationController
    def index
      @q = District.ransack(params[:q])
      @districts = @q.result.page(params[:page]).per(params[:per] || 10)
    end
  end
end
