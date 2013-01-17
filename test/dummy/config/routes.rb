Rails.application.routes.draw do

  mount SmsConfirmable::Engine => "/sms_confirmable"
end
