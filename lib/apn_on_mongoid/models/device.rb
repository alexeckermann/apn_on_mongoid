module APN
  class Device

    include Mongoid::Document
    include Mongoid::Timestamps

    field :udid
    field :device_info

    index :udid, :unique => true, :background => true
    
    referenced_in :notification, :class_name => "APN::Notification", :inverse_of => :device
    
    embeds_many :subscriptions, :class_name => "APN::Subscription"
    
    validates_presence_of :udid
    validates_uniqueness_of :udid

  end
end