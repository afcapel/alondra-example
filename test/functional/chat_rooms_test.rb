require 'test_helper'

# Define a bare test case to use with Capybara
class ChatRoomsTest < ActiveSupport::TestCase

  # You would probably want to create a super class for all your integration tests
  # and include these modules there.
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  self.use_transactional_fixtures = false

  setup do
    clean_db
    Capybara.default_driver = :selenium
  end

  teardown do
    clean_db
  end

  test "two guys enter a chat room..." do
    chat_room = ChatRoom.create(:name => 'World Affairs')

    fred = User.create(:username =>'Fred',    :email => 'fred@example.com',
                       :password => 'secret', :password_confirmation => 'secret')


    george = User.create(:username =>'George',  :email => 'george@example.com',
                         :password => 'secret', :password_confirmation => 'secret')


    using_session :fred do
      login_as fred
      visit chat_room_path chat_room

      wait_until(20) do
        page.has_content? 'Fred' # See Fred username in users list
      end

      assert !page.has_content?('George') # George is not in the chat room yet
    end

    using_session :george do
      login_as george
      visit chat_room_path chat_room

      wait_until(10) do
        page.has_content?('Fred') &&  page.has_content?('George')
      end
    end

    using_session :fred do

      # Fred sees George
      wait_until(10) do
        page.has_content? 'George'
      end

      # Fred writes a message

      fill_in 'message_text', :with => 'Hi, George!'
      click_button 'send'

      wait_until(10) do
        page.has_content?('Hi, George!')
      end
    end


    using_session :fred do
      # George sees the message

      wait_until(10) do
        page.has_content?('Hi, George!')
      end
    end
  end


  def login_as(user)
    visit new_session_path
    fill_in "login", :with => user.username
    fill_in "password", :with => "secret"
    click_button "Log in"
  end

  def log_out
    click_link _('logout')
  end

  def clean_db
    [Presence, Message, User, ChatRoom].each { |model| model.delete_all }
  end
end