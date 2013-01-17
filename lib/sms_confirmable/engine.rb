module SmsConfirmable
  class Engine < ::Rails::Engine
    isolate_namespace SmsConfirmable
    ActiveSupport.on_load(:action_controller) do
      include ::SmsConfirmable::Controllers::Helpers
    end
  end
end
