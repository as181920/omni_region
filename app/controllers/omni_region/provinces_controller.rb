module OmniRegion
  class ProvincesController < ApplicationController
    def index
      @q = Province.ransack(params[:q])
      @provinces = @q.result.page(params[:page]).per(params[:per] || 10)
    end
  end
end
