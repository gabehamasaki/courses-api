class CoursesController < ApplicationController
  before_action :authorize_request, except: %i[ index show ]
  before_action :set_course, only: %i[ show update destroy join ]
  before_action :verify_teacher, only: %i[ create ]
  before_action :verify_student, only: %i[ join ]
  
  # GET /courses
  def index
    @courses = Course.all

    render json: @courses
  end

  # GET /courses/1
  def show
    render json: {
      id: @course.id,
      name: @course.name,
      description: @course.description,
      value: @course.value,
      image_url: url_for(@course.image),
      teacher: @course.teacher,
      students: @course.students,
      topics: @course.topics
    }
  end

  # POST /courses
  def create
    @course = Course.new(course_params)
    if @course.save
      render json: @course, status: :created, location: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  # POST /courses/:course_id/join
  def join
    if @course.students << @student
      head :no_content
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/1
  def update
    if @course.update(course_params)
      render json: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
      if !@current || @current == @course.teacher || @current.role.name == 'Admin'
        return @course
      else
        render json: { error: 'Only the teacher of this course can access it' }, status: :bad_request
      end
    end

    def verify_teacher
      if (params[:teacher_id].nil?)
        @teacher = @current
      else
        @teacher = User.find(params[:teacher_id])
      end
      if (@teacher.role.name == 'Teacher')
        return @teacher
      else
        render json: { error: 'Only the teacher can be associated with a course.' }, status: :bad_request
      end
    end

    def verify_student
      if (params[:student_id].nil?)
        params[:student_id] = @current.id
      end
      @student = User.find(params[:student_id])

      userAlreadyEnrolled = @course.students.include?(@student)

      if (@student.role.name == 'Member' && !userAlreadyEnrolled)
        return @student
      elsif (userAlreadyEnrolled)
        render json: { error: 'This student is already enrolled in this course' }, status: :bad_request
      else
        render json: { error: 'Only students can take part in the courses' }, status: :bad_request
      end
    end
    
    # Only allow a list of trusted parameters through.
    def course_params
      params.permit(:name, :description, :teacher_id, :value, :image)
    end
end
