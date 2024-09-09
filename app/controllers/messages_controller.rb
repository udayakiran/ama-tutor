class MessagesController < ApplicationController
  def create
    @chat = Chat.find(params[:chat_id])
    role = @chat.messages.any? ? 'user' : 'user'
    @message = Message.create!(message_params.merge(chat_id: params[:chat_id], role: role))

    # OpenaiResponseJob.perform_later(@message.chat_id) uncomment this if you like to use OpenAI based responses.
    # OllamaResponseJob.perform_later(@message.chat_id) uncomment this if you like the LLM calls to be done in background
    # as sycb sidekick jobs.

    OllamaResponseJob.new.perform(@message.chat_id) #Just calling these directly for now.

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end