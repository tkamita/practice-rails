class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
    # binding.pry
    # フロントエンドとバックエンドを監視しあう
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = Message.create!(content: data['message'])
    template = ApplicationController.renderer.render(partial: 'messages/message', locals: {message: message})
    ActionCable.server.broadcast 'room_channel', template
  end
end
