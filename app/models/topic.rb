class Topic < ApplicationRecord
  belongs_to :course
  has_many :lessons, dependent: :destroy

  validates :name, presence: true
  validates :order, presence: true, uniqueness: { scope: :course_id }
  validates :course_id, presence: true
end
