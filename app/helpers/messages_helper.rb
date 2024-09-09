module MessagesHelper
  def icon_for(message)
    case message.role
    when 'system'
      '<i class="fa-duotone fa-star"></i>'
    when 'user'
      '<i class="fa-duotone fa-user"></i>'
    when 'assistant'
      '<i class="fa-duotone fa-microchip-ai"></i>'
    end
  end
end
