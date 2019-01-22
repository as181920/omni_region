module OmniRegion
  class District < Division
    belongs_to :city, foreign_key: :parent_id
    has_one :province, through: :city
    has_one :country, through: :province
  end
end
