module OmniRegion
  class Province < Division
    belongs_to :country, foreign_key: :parent_id
    has_many :cities, foreign_key: :parent_id
    has_many :districts, through: :cities
  end
end
