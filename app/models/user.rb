class User < ApplicationRecord
  has_secure_password
  belongs_to :role
  has_many :courses, class_name: 'Course', foreign_key: 'teacher_id'
  has_and_belongs_to_many :enrollments, class_name: 'Course'

  has_one_attached :avatar

  def as_json(options={})
    {
      :id => id,
      :name => name,
      :email => email,
      :role => role.name,
      :avatar => avatar.attached? ? Rails.application.routes.url_helpers.rails_blob_url(avatar, only_path: true) : nil,
      :created_at => created_at,
      :updated_at => updated_at,
    }
  end

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: false
  validates :role_id, presence: true
end
