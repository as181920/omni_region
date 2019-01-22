module OmniRegion
  class Division < ApplicationRecord
    validates_presence_of :type, :name
    validates :code, presence: true, uniqueness: true

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
