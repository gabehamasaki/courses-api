class User < ApplicationRecord
  has_secure_password
  belongs_to :role

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: false
  validates :role_id, presence: true
end
