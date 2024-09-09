# == Schema Information
#
# Table name: lectures
#
#  id         :bigint           not null, primary key
#  title      :string
#  content    :text
#  file_path  :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Lecture2 < ApplicationRecord
  include ActionView::RecordIdentifier
  
  #belongs_to :chat

  after_create_commit -> { index_content }
  after_update_commit -> { index_content }

  def index_content
   
  end

  def broadcast_updated
    
  end
end
