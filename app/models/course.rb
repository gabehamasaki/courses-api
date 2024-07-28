class Course < ApplicationRecord
  belongs_to :teacher, class_name: 'User'
  has_many :topics, dependent: :destroy
  has_and_belongs_to_many :students, class_name: 'User'
  has_one_attached :image

  def as_json(options={})
    {
      :id => id,
      :name => name,
      :description => description,
      :value => value,
      :image => image.attached? ? Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true) : nil,
      :teacher => {
        :id => teacher.id,
        :name => teacher.name,
        :email => teacher.email,
        :avatar => teacher.avatar.attached? ? Rails.application.routes.url_helpers.rails_blob_url(teacher.avatar, only_path: true) : nil,
      },
      :students => students.map { |student| {
        :id => student.id,
        :name => student.name,
        :email => student.email,
        :avatar => student.avatar.attached? ? Rails.application.routes.url_helpers.rails_blob_url(student.avatar, only_path: true) : nil,
      } },
    }
  end

  validates :name, presence: true
  validates :description, presence: true
  validates :value, presence: true
  validates :teacher_id, presence: false
  validates :image, presence: true
end
