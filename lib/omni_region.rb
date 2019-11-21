require "omni_region/engine"

module OmniRegion
  extend ActiveSupport::Concern

  included do
    # belongs_to :division, class_name: "::OmniRegion::Division", foreign_key: :division_code, primary_key: :code, optional: true
    # belongs_to :country, class_name: "::OmniRegion::Country", foreign_key: :country_code, primary_key: :code, optional: true
    # belongs_to :province, class_name: "::OmniRegion::Province", foreign_key: :province_code, primary_key: :code, optional: true
    # belongs_to :city, class_name: "::OmniRegion::City", foreign_key: :city_code, primary_key: :code, optional: true
    # belongs_to :district, class_name: "::OmniRegion::District", foreign_key: :district_code, primary_key: :code, optional: true
  end
end
