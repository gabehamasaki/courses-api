class Course < ApplicationRecord
  belongs_to :teacher, class_name: 'User'
  has_many :topics, dependent: :destroy
  has_and_belongs_to_many :students, class_name: 'User'
  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :value, presence: true
  validates :teacher_id, presence: false
  validates :image, presence: true
end
