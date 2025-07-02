class RoomsController < ApplicationController
  before_action :authenticate_user!
  def show
    @room = Room.find(params[:id])
    @message = Message.new
    @messages = @room.messages.includes(:user)
  end
end
