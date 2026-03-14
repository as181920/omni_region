module OmniRegion
  class ProvincesController < ApplicationController
    def index
      @q = Province
        .then { |scope| params[:q].is_a?(ActionController::Parameters) && params[:q][:s].present? ? scope : scope.order(name: :asc) }
        .ransack(params[:q])
      @provinces = @q.result.page(params[:page]).per(params[:per] || 10)
    end
  end
end
