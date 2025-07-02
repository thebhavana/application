module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # We start code here
    identified_by :current_user
    def connect
      self.current_user = env["warden"].user
      reject_unauthorized_connection unless current_user
    end
  end
end
