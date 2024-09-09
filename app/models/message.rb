# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  chat_id    :bigint           not null
#  role       :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Message < ApplicationRecord
  include ActionView::RecordIdentifier
  
  belongs_to :chat

  after_create_commit -> { broadcast_created }
  after_update_commit -> { broadcast_updated }

  def broadcast_created
    broadcast_append_to(
      "#{dom_id(chat)}_messages",
      partial: "messages/message",
      locals: { message: self, scroll_to: true },
      target: "#{dom_id(chat)}_messages"
    )
  end

  def broadcast_updated
    broadcast_append_to(
      "#{dom_id(chat)}_messages",
      partial: "messages/message",
      locals: { message: self, scroll_to: false },
      target: "#{dom_id(chat)}_messages"
    )
  end
end
