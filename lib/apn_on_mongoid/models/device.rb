module APN
  class Device

    include Mongoid::Document
    include Mongoid::Timestamps

    field :udid
    field :token
    field :last_registered_at, :type => DateTime
    field :feedback_at, :type => DateTime

    index :udid, :unique => true, :background => true
    
    referenced_in :notification, :class_name => "APN::Notification", :inverse_of => :device
    
    validates_uniqueness_of :token
    validates_format_of :token, :with => /^[a-z0-9]{8}\s[a-z0-9]{8}\s[a-z0-9]{8}\s[a-z0-9]{8}\s[a-z0-9]{8}\s[a-z0-9]{8}\s[a-z0-9]{8}\s[a-z0-9]{8}$/

    # The <tt>feedback_at</tt> accessor is set when the 
    # device is marked as potentially disconnected from your
    # application by Apple.
    attr_accessor :feedback_at

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

    private
    
      def set_last_registered_at
        self.last_registered_at = Time.now if self.last_registered_at.nil?
      end

  end
end