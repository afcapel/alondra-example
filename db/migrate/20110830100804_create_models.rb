class CreateModels < ActiveRecord::Migration
  def change
    create_table :chat_rooms do |t|
      t.string :name
      t.timestamps
    end

    create_table :messages do |t|
      t.integer :chat_room_id
      t.string :text
      t.timestamps
    end

    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.string :access_token
      t.timestamps
    end

    create_table :presences do |t|
      t.integer :user_id
      t.integer :chat_room_id
      t.integer :count, :default => 0
      t.timestamps
    end
  end
end
