class MessagesController < ApplicationController
  respond_to :js

  def create
    @chat_room = ChatRoom.find(params[:chat_room_id])
    @message = @chat_room.messages.build(params[:message])

    @message.save

    push :template => '/messages/create', :to => @chat_room
  end
end