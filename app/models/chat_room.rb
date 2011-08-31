class ChatRoom < ActiveRecord::Base
  has_many :messages
  has_many :presences
  has_many :users, :through => :presences
end
