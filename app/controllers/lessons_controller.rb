class LessonsController < ApplicationController
  before_action :set_share
  before_action :set_lesson, only: %i[ show update destroy ]

  # GET /lessons
  def index
    @lessons = Lesson.where(topic_id: params[:topic_id])

    render json: @lessons
  end

  # GET /lessons/1
  def show
    render json: {
      id: @lesson.id,
      name: @lesson.name,
      description: @lesson.description,
      order: @lesson.order,
      video_url: url_for(@lesson.video),
      topic: @lesson.topic
    }
  end

  # POST /lessons
  def create
    @lesson = Lesson.new(lesson_params)

    if @lesson.save
      render json: @lesson, status: :created
    else
      render json: @lesson.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lessons/1
  def update
    if @lesson.update(lesson_params)
      render json: @lesson
    else
      render json: @lesson.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lessons/1
  def destroy
    @lesson.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    def set_share 
      @course = Course.find(params[:course_id])
      @topic = Topic.find(params[:topic_id])
    end

    # Only allow a list of trusted parameters through.
    def lesson_params
      params.permit(:name, :description, :order, :video).merge(topic_id: params[:topic_id])
    end
end
