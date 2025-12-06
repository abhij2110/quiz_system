class Quiz < ApplicationRecord
  has_many :questions, -> { order(:position) }, dependent: :destroy

  accepts_nested_attributes_for :questions, allow_destroy: true

  validates :title, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[id title created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
