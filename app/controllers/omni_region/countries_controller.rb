module OmniRegion
  class CountriesController < ApplicationController
    def index
      @q = Country
        .then { |scope| params[:q].is_a?(ActionController::Parameters) && params[:q][:s].present? ? scope : scope.order(name: :asc) }
        .ransack(params[:q].is_a?(ActionController::Parameters) ? params[:q] : {})
      @countries = @q.result.page(params[:page]).per(params[:per] || 25)
    end
  end
end
