class TopicsController < ApplicationController
  before_action :set_course
  before_action :set_topic, only: %i[ show update destroy ]

  # GET /topics
  def index
    @topics = Topic.where(course_id: params[:course_id])
    
    render json: @topics
  end

  # GET /topics/1
  def show
    render json: @topic, include: [:lessons]
  end

  # POST /topics
  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      render json: @topic, status: :created
    else
      render json: @topic.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /topics/1
  def update
    if @topic.update(topic_params)
      render json: @topic
    else
      render json: @topic.errors, status: :unprocessable_entity
    end
  end

  # DELETE /topics/1
  def destroy
    @topic.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    def set_course
      @course = Course.find(params[:course_id])
    end

    # Only allow a list of trusted parameters through.
    def topic_params
      params.permit(:name, :order).merge(course_id: params[:course_id])
    end
end
