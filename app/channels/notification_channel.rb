class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'NotificationChannel'
  end

  def unsubscribed; end
end
