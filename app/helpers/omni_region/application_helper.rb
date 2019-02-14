module OmniRegion
  module ApplicationHelper
    def province_options_for_select(country_code, selected_code)
      options_for_select(OmniRegion::Province.where(parent_id: OmniRegion::Country.find_by(code: country_code || 156)&.id).pluck(:name, :code), selected_code)
    end

    def city_options_for_select(province_code, selected_code)
      options_for_select(OmniRegion::City.where(parent_id: OmniRegion::Province.find_by(code: province_code)&.id).pluck(:name, :code), selected_code)
    end

    def district_options_for_select(city_code, selected_code)
      options_for_select(OmniRegion::District.where(parent_id: OmniRegion::City.find_by(code: city_code)&.id).pluck(:name, :code), selected_code)
    end
  end
end
