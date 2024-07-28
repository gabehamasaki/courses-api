class Lesson < ApplicationRecord
  belongs_to :topic
  has_one_attached :video


  def as_json(options={})
    {
      :id => id,
      :name => name,
      :description => description,
      :order => order,
      :video => Rails.application.routes.url_helpers.rails_blob_url(video, only_path: true),
      :topic => {
        :id => topic.id,
        :name => topic.name,
        :url => Rails.application.routes.url_helpers.topic_path(topic.id),
      },
      :course => {
        :id => topic.course.id,
        :name => topic.course.name,
        :description => topic.course.description,
        :url => Rails.application.routes.url_helpers.course_path(topic.course.id),
      },
      :created_at => created_at,
      :updated_at => updated_at,
    }
  end

  validates :name, presence: true
  validates :description, presence: true
  #  unique per topic
  validates :order, presence: true, uniqueness: { scope: :topic_id }
  validates :video, presence: true
  validates :topic_id, presence: true
end
