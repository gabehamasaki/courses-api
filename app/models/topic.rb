class Topic < ApplicationRecord
  belongs_to :course
  has_many :lessons, dependent: :destroy

  def as_json(options={})
    {
      :id => id,
      :name => name,
      :order => order,
      :course => {
        :id => course.id,
        :name => course.name,
        :description => course.description,
        :image => course.image.attached? ? Rails.application.routes.url_helpers.rails_blob_url(course.image, only_path: true) : nil,
      },
      :lessons => lessons.map { |lesson| lesson.as_json },
      :created_at => created_at,
      :updated_at => updated_at,
    }
  end

  validates :name, presence: true
  validates :order, presence: true, uniqueness: { scope: :course_id }
  validates :course_id, presence: true
end
