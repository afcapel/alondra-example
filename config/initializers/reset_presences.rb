# Reset all presences to start with empty chat rooms
Presence.delete_all if Presence.table_exists?