module SmsConfirmable
  module Orm
    module ActiveRecord
      module Schema
        include SmsConfirmable::Schema
      end
    end
  end
end

ActiveRecord::ConnectionAdapters::Table.send :include, SmsConfirmable::Orm::ActiveRecord::Schema
ActiveRecord::ConnectionAdapters::TableDefinition.send :include, SmsConfirmable::Orm::ActiveRecord::Schema
