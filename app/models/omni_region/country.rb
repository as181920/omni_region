module OmniRegion
  class Country < Division
    has_many :provinces, foreign_key: :parent_id
    has_many :cities, through: :provinces
    has_many :districts, through: :cities
  end
end
