require 'active_support/dependencies'
require 'socket'
require 'openssl'

module APN # :nodoc:
  
  # Host to send APNS requests to. Assumed the sandbox.
  mattr_accessor :host
  @@host = (::Rails.env == "production" ? 'gateway.push.apple.com' : 'gateway.sandbox.push.apple.com')
  
  # Port number for the APNS
  mattr_accessor :port
  @@port = 2195
  
  # Feedback host. Assumed sandbox
  mattr_accessor :feedback
  @@feedback = (::Rails.env == "production" ? 'feedback.push.apple.com' : 'feedback.sandbox.push.apple.com')
  
  # Port number for the APNS feedback
  mattr_accessor :feedback_port
  @@feedback_port = 2196
  
  # Port number for the APNS feedback
  mattr_accessor :cert
  @@cert = File.join(::Rails.root.to_s, 'config', (::Rails.env == "production" ? 'apns_certificate_production.pem' : 'apns_certificate_development.pem')) # THIS DONT WORK! Rails.root isnt set at this point :(
  
  # Passphrase for certificate
  mattr_accessor :passphrase
  @@passphrase = ''
  
  # Default way to setup APN on Mongoid.
  def self.setup
    yield self
  end
  
  module Errors # :nodoc:
    
    # Raised when a notification message to Apple is longer than 256 bytes.
    class ExceededMessageSizeError < StandardError
      MAX_BYTES = 255
      def initialize(message) # :nodoc:
        super("The maximum size allowed for a notification payload is #{MAX_BYTES} bytes: '#{message}'")
      end
    end
    
  end # Errors
  
end # APN

require 'apn_on_mongoid/connection'
require 'apn_on_mongoid/feedback'
require 'apn_on_mongoid/models/device'
require 'apn_on_mongoid/models/notification'
require 'apn_on_mongoid/models/application'
require 'apn_on_mongoid/models/subscription'