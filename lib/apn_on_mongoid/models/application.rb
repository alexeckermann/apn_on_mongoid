module APN
  class Application
    
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name
    field :identifier
    field :certificate

    index :identifier, :unique => true, :background => true
    
    # references_many :subscriptions, :class_name => "APN::Subscription", :inverse_of => :application
    
  end
end