class ChatRoomsController < ApplicationController
  before_filter :login_required

  def index
    @chat_rooms = ChatRoom.all
  end

  def show
    @chat_room = ChatRoom.find(params[:id])
  end

  def create
    @chat_room = ChatRoom.new(params[:chat_room])

    if @chat_room.save
      redirect_to @chat_room, notice: 'ChatRoom was successfully created.'
    else
      render action: "new"
    end
  end
end
