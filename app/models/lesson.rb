class Lesson < ApplicationRecord
  belongs_to :topic
  has_one_attached :video

  validates :name, presence: true
  validates :description, presence: true
  #  unique per topic
  validates :order, presence: true, uniqueness: { scope: :topic_id }
  validates :video, presence: true
  validates :topic_id, presence: true
end
