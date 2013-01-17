module ActionDispatch::Routing
  class Mapper
    protected

    def devise_sms_confirmation(mapping, controllers)
      resource(:confirm_phone_number, :only => [:show, :create, :new], 
               :path => mapping.path_names[:confirm_phone_number],
               :controller => controllers[:confirm_phone_number]
              )
    end
    
  end
end
