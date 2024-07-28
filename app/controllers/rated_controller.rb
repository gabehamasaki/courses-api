class RatedController < ApplicationController
  def courses
    # Return last 10 course
    @courses = Course.limit(10).order('created_at desc')
    render json: @courses
 end 
end
