class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_#{params['room_id']}_channel"
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create!(
      content: data["messsage"],
      user_id: current_user.id,
      room_id: params["room_id"]
    )
  end
end
