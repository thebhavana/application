class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  after_create_commit { broadcast_message }
  def broadcast_message
    ActionCable.server.broadcast(
      "room_#{room_id}_channel",
      {
        message: content,
        user: user.email, # or user.name
        timestamp: created_at.strftime("%H:%M")
      }
    )
  end
end
