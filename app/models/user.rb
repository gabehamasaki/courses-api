class User < ApplicationRecord
  has_secure_password
  belongs_to :role
  has_and_belongs_to_many :courses
  has_and_belongs_to_many :enrollments, class_name: 'Course'

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: false
  validates :role_id, presence: true
end
