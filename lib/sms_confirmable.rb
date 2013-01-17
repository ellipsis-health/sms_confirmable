require 'sms_confirmable/version'
require 'devise'
require 'scrypt'
require 'securerandom'
require 'active_support/concern'

module Devise
  mattr_accessor :confirmation_code_length
  @@confirmation_code_length = 6

  mattr_accessor :confirmation_code_includes_lowercase
  @@confirmation_code_includes_lowercase = false

  mattr_accessor :max_confirmation_attempts
  @@max_confirmation_attempts = 3
end

module SmsConfirmable
  autoload :Schema, 'sms_confirmable/schema'
  module Controllers
    autoload :Helpers, 'sms_confirmable/controllers/helpers'
  end
end

Devise.add_module(:sms_confirmable, 
                  :model => 'sms_confirmable/models/sms_confirmable',
                  :controller => :sms_confirmation,
                  :route => :sms_confirmation)
               

require 'sms_confirmable/orm/active_record'
require 'sms_confirmable/routes'
require 'sms_confirmable/models/sms_confirmable'
require 'sms_confirmable/engine'
