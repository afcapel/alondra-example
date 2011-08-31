class ChatListener < Alondra::EventListener

  on :subscribed, :to => :member do
    puts "subscribed to #{chat_room.id}"
    presence.increment!
  end

  on :unsubscribed, :to => :member do
    puts "unsubscribed from #{chat_room.id}"
    presence.decrement! if chat_room.present? && user.present?
  end

  private

  def presence
    @presence ||= Presence.find_or_create_by_user_id_and_chat_room_id(user.id, chat_room.id)
  end

  def chat_room
    @chat_room ||= fetch_chat_room
  end

  def fetch_chat_room
    if channel_name =~ /chat_rooms\/(\d+)/
      ChatRoom.where(:id => $1).first
    end
  end

  def user
    resource
  end
end