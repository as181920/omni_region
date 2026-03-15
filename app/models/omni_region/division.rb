module OmniRegion
  class Division < ApplicationRecord
    belongs_to :parent, class_name: "OmniRegion::Division", optional: true
    has_many :children, class_name: "OmniRegion::Division", foreign_key: :parent_id, inverse_of: :parent, dependent: nil

    validates :type, :name, presence: true
    validates :code, presence: true, uniqueness: true

    def self.ransackable_attributes(_auth_object = nil)
      %w[id parent_id code name]
    end

    def self.ransackable_associations(_auth_object = nil)
      %w[parent]
    end

    def to_param
      code
    end

    def to_s
      name
    end
  end
end
