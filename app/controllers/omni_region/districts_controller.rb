module OmniRegion
  class DistrictsController < ApplicationController
    def index
      @q = District
        .then { |scope| params[:q].is_a?(ActionController::Parameters) && params[:q][:s].present? ? scope : scope.order(name: :asc) }
        .ransack(params[:q].is_a?(ActionController::Parameters) ? params[:q] : {})
      @districts = @q.result.page(params[:page]).per(params[:per] || 10)
    end
  end
end
