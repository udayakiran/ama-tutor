  class LectureKbJob < ApplicationJob
    queue_as :default

    def perform(user_id)
      
    end

    def index_lecture_transcripts(user_id)
      Lecture.find(user_id: user_id)
      filepaths = Lecture.map(&:transcripts)
    end


  end
