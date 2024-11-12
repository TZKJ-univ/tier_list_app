class FixAutoIncrementForAllTables < ActiveRecord::Migration[6.1]
  def up
    # PostgreSQLでのみ実行
    if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
      ActiveRecord::Base.connection.tables.each do |table_name|
        if ActiveRecord::Base.connection.column_exists?(table_name, :id)
          sequence_name = "#{table_name}_id_seq"
          execute("CREATE SEQUENCE IF NOT EXISTS #{sequence_name}")
          execute("ALTER TABLE #{table_name} ALTER COLUMN id SET DEFAULT nextval('#{sequence_name}')")
          execute("ALTER SEQUENCE #{sequence_name} OWNED BY #{table_name}.id")
          puts "Auto-increment sequence set for #{table_name}.id"
        end
      end
    else
      puts "This migration is intended for PostgreSQL only."
    end
  end
end