module OmniRegion
  class City < Division
    belongs_to :province, foreign_key: :parent_id, inverse_of: :cities
    has_one :country, through: :province
    has_many :districts, foreign_key: :parent_id, inverse_of: :city, dependent: nil
  end
end
