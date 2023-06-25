module OmniRegion
  class CitiesController < ApplicationController
    def index
      @q = City
        .then { |scope| params.dig(:q, :s).present? ? scope : scope.order(name: :asc) }
        .ransack(params[:q])
      @cities = @q.result.page(params[:page]).per(params[:per] || 10)
    end
  end
end
