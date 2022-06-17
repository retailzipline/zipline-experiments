class Experiment < ApplicationRecord
  belongs_to :created_by_user, class_name: 'User'
  belongs_to :updated_by_user, class_name: 'User'

  validates :title, presence: true
  validates :key, presence: true

  before_validation :generate_key, on: :create

  private

  def generate_key
    SecureRandom.hex(3)
  end
end
