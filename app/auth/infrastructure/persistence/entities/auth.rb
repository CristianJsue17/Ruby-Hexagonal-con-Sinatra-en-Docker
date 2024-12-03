require 'active_record'

module Infrastructure
  module Persistence
    module Entities
      class Auth < ActiveRecord::Base
        self.table_name = 'users'
      end
    end
  end
end