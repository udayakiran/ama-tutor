  class OllamaResponseJob < ApplicationJob
    queue_as :default

    def perform(chat_id)
      chat = Chat.find (chat_id)
      call_ollama(chat)
    end

    def call_ollama(chat)

      message = chat.messages.create ({role: 'assistant', content: ''})

      client = Ollama.new( credentials: { address: ENV['OLLAMA_API']}, options: { server_sent_events: true })

      result = client.chat(
        { model: 'llama3.1',
          messages: chat.messages.map { |m| {role:m.role, content: m.content}  }
        }
        ) do |event, _raw|
        message = if chat.messages.last.role == 'assistant'
            chat.messages.last
          else
            chat.messages.create(role: 'assistant', content: '')
          end
        stream_proc(message, event)
      end

    end


    def stream_proc(message, event)

      new_content = event.dig('message', 'content')
      message.update(content: message.content + new_content) if new_content

    end

  end
