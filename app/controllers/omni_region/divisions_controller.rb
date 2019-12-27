module OmniRegion
  class DivisionsController < ApplicationController
    before_action :set_division, only: [:show, :edit, :update, :destroy]

    def index
      @q = Division.ransack(params[:q])
      @divisions = @q.result.page(params[:page]).per(params[:per] || 25)
    end

    def show
    end

    private
      def set_division
        @division = Division.find_by(code: params[:code])
      end
  end
end
