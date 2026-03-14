module OmniRegion
  class CitiesController < ApplicationController
    def index
      @q = City
        .then { |scope| params[:q].is_a?(ActionController::Parameters) && params[:q][:s].present? ? scope : scope.order(name: :asc) }
        .ransack(params[:q])
      @cities = @q.result.page(params[:page]).per(params[:per] || 10)
    end
  end
end
