module Support
  module PgHelpers
    def fetch_next_id_for(model)
      ActiveRecord::Base.
        connection.
        execute("select last_value from #{model.table_name}_id_seq").
        first['last_value'] + 1
    end
  end
end
RSpec.configure do |config|
  config.include Support::PgHelpers
end
