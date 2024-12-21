module OmniRegion
  class District < Division
    belongs_to :city, foreign_key: :parent_id, inverse_of: :districts
    has_one :province, through: :city
    has_one :country, through: :province
  end
end
