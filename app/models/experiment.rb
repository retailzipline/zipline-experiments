class Experiment < ApplicationRecord
  audited

  belongs_to :created_by_user, class_name: 'User'
  belongs_to :updated_by_user, class_name: 'User'

  validates :title, presence: true
  validates :key, presence: true

  before_validation :generate_key, on: :create

  def to_param
    key
  end

  private

  def generate_key
    self[:key] = SecureRandom.hex(3)
  end
end
