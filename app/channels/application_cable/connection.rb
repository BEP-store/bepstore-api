# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include UsersHelper

    # Hackery. I'd prefer to use current_user instead of the_current_user,
    # but ActionCable would then override the existing current_user method.
    identified_by :the_current_user
    alias the_current_user current_user

    def on_error(error)
      puts error
    end

    def new_tagged_logger
      Logger.new(STDOUT)
    end
  end
end
