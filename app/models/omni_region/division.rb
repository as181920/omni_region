module OmniRegion
  class Division < ApplicationRecord
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

    def parent
      Division.find_by(id: parent_id)
    end

    def children
      Division.where(parent_id: id)
    end
  end
end
