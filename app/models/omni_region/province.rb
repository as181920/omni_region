module OmniRegion
  class Province < Division
    belongs_to :country, foreign_key: :parent_id, inverse_of: :provinces
    has_many :cities, foreign_key: :parent_id, inverse_of: :province, dependent: nil
    has_many :districts, through: :cities
  end
end
