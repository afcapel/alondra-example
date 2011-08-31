# You can start an Alondra server from your rails initializers.
# The server will run in its own thread.
#
# This is handy in development, but be careful to use in production.
# Some execution environments, such as passenger, start and end multiple
# rails instances. This can mess with your Alondra server connections

if Rails.env != 'production' && !defined?(PhusionPassenger)
  ENV["ALONDRA_SERVER"] = 'true'
  Alondra::Alondra.start!

  puts "Started alondra server from Rails initializer"
  Rails.logger.info "Started alondra server from Rails initializer"
else
  puts "WTF"
end