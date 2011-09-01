class ChatListener < Alondra::EventListener

  on :subscribed, :to => :member do
    presence = Presence.find_or_create_by_user_id_and_chat_room_id(session[:user_id], chat_room_id)
    presence.increment!
  end

  on :unsubscribed, :to => :member do
    presence = Presence.find_or_create_by_user_id_and_chat_room_id(session[:user_id], chat_room_id)
    presence.decrement!
  end

  private

  def chat_room_id
    channel_name.match(/chat_rooms\/(\d+)/)[1]
  end
end