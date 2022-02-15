class LectureTimesController < ApplicationController

  # GET /lecture_times or /lecture_times.json
  def index
    @lecture_times = LectureTime.all
  end

end
