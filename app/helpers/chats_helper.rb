module ChatsHelper
  def list_name(chat)
    if chat.messages.any?
      chat.messages.first.content.truncate(25)
    else
      "Chat #{chat.id}"
    end
  end
end
