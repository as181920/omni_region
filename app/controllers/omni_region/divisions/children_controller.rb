require_dependency "omni_region/application_controller"

module OmniRegion
  class Divisions::ChildrenController < ApplicationController
    before_action :set_division

    def index
      @children = @division.children.order(code: :asc)
    end

    private
      def set_division
        @division = Division.find_by(code: params[:division_code])
      end
  end
end
