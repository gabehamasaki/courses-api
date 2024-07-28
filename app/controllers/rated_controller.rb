class RatedController < ApplicationController
  before_action :authorize_request, except: [:courses]
  def courses
    # Return last 10 course
    @courses = Course.limit(10).order('created_at desc')
    render json: {
      courses: @courses.map do |course|
        {
          id: course.id,
          name: course.name,
          description: course.description,
          value: course.value,
          image_url: url_for(course.image),
          teacher: course.teacher,
        }
      end
    }
 end 
end
