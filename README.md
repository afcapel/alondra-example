# Alondra Example Application

This is an example application of the [alondra gem](http://github.com/afcapel/alondra).

Some interesting files in the app are:

- *app/views/chat_rooms/show.html.erb* Using the JavaScript API to subscribe to a client and render updates.
- *app/controllers/messages_controller.rb* Sending push message from controller.
- *app/models/presence.rb* Pushing changes in presences to a channel.
- *app/listener/chat_listener.rb* Example listener to count which users are in a chat room.
- *test/functional/chat_rooms_test.rb* Example test showing how to test multiple browsers with Capybara.
- *config/initializers/alondra_server.rb* For how to run the alondra server automatically in develpment.

