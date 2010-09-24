module APN
  class Subscription
    
    include Mongoid::Document
    include Mongoid::Timestamps

    field :token

    index :token, :unique => true, :background => true
    
    validates_uniqueness_of :token
    validates_format_of :token, :with => /^[a-z0-9]{8}\s[a-z0-9]{8}\s[a-z0-9]{8}\s[a-z0-9]{8}\s[a-z0-9]{8}\s[a-z0-9]{8}\s[a-z0-9]{8}\s[a-z0-9]{8}$/
    
    embedded_in :device, :class_name => "APN::Device", :inverse_of => :subscriptions
    
    referenced_in :application, :class_name => "APN::Application"
    
    # Stores the token (Apple's device ID) of the iPhone (device).
    # 
    # If the token comes in like this:
    #  '<5gxadhy6 6zmtxfl6 5zpbcxmw ez3w7ksf qscpr55t trknkzap 7yyt45sc g6jrw7qz>'
    # Then the '<' and '>' will be stripped off.
    def token=(token)
      res = token.scan(/\<(.+)\>/).first
      unless res.nil? || res.empty?
        token = res.first
      end
      write_attribute('token', token)
    end

    # Returns the hexadecimal representation of the device's token.
    def to_hexa
      [self.token.delete(' ')].pack('H*')
    end
    
  end
end