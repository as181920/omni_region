module OmniRegion
  module ApplicationHelper
    def province_options_for_select(country_code, selected_code)
      options_for_select(OmniRegion::Province.where(parent_id: OmniRegion::Country.find_by(code: country_code || 156)&.id).order(code: :asc).pluck(:name, :code), selected_code)
    end

    def city_options_for_select(province_code, selected_code)
      options_for_select(OmniRegion::City.where(parent_id: OmniRegion::Province.find_by(code: province_code)&.id).order(code: :asc).pluck(:name, :code), selected_code)
    end

    def district_options_for_select(city_code, selected_code)
      options_for_select(OmniRegion::District.where(parent_id: OmniRegion::City.find_by(code: city_code)&.id).order(code: :asc).pluck(:name, :code), selected_code)
    end

    def province_options_of_division(division_code)
      division = OmniRegion::Division.find_by(code: (division_code.presence || 156))
      case division&.type
      when "OmniRegion::District", "OmniRegion::City"
        options_for_select(division.country.provinces.order(code: :asc).pluck(:name, :code), division.province.code)
      when "OmniRegion::Province"
        options_for_select(division.parent.provinces.order(code: :asc).pluck(:name, :code), division.code)
      when "OmniRegion::Country"
        options_for_select(division.provinces.order(code: :asc).pluck(:name, :code), nil)
      else
        options_for_select([], nil)
      end
    end

    def city_options_of_division(division_code)
      division = OmniRegion::Division.find_by(code: division_code)
      case division&.type
      when "OmniRegion::District"
        options_for_select(division.province.cities.order(code: :asc).pluck(:name, :code), division.city.code)
      when "OmniRegion::City"
        options_for_select(division.parent.cities.order(code: :asc).pluck(:name, :code), division.code)
      when "OmniRegion::Province"
        options_for_select(division.cities.order(code: :asc).pluck(:name, :code), nil)
      else
        options_for_select([], nil)
      end
    end

    def district_options_of_division(division_code)
      division = OmniRegion::Division.find_by(code: division_code)
      case division&.type
      when "OmniRegion::District"
        options_for_select(division.parent.districts.order(code: :asc).pluck(:name, :code), division.code)
      when "OmniRegion::City"
        options_for_select(division.districts.order(code: :asc).pluck(:name, :code), nil)
      else
        options_for_select([], nil)
      end
    end

    def full_name_of_division(division_code)
      division = OmniRegion::Division.find_by(code: division_code)
      name = division&.name.to_s
      division&.parent&.parent ? name.prepend("#{full_name_of_division(division.parent.code)}-") : name
    end
  end
end
