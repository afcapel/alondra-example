class Presence < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat_room

  # Will push created and destroyed events to the chat room channel
  push :creations, :destroys, :to => :chat_room

  def increment!
    increment :count
    save!
  end

  def decrement!
    decrement :count
    count < 1 ? destroy : save!
  end

  def as_json
    super.merge :username  => user.username
  end
end