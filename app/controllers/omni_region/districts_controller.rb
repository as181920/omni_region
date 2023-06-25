module OmniRegion
  class DistrictsController < ApplicationController
    def index
      @q = District
        .then { |scope| params.dig(:q, :s).present? ? scope : scope.order(name: :asc) }
        .ransack(params[:q])
      @districts = @q.result.page(params[:page]).per(params[:per] || 10)
    end
  end
end
