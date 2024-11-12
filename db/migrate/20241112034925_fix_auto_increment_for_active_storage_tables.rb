class FixAutoIncrementForActiveStorageTables < ActiveRecord::Migration[6.1]
  def up
    # PostgreSQLでのみ実行
    if ActiveRecord::Base.connection.adapter_name.downcase.include?('postgresql')
      %w[active_storage_blobs active_storage_attachments].each do |table_name|
        sequence_name = "#{table_name}_id_seq"
        
        # シーケンスが存在しなければ新規作成
        execute("CREATE SEQUENCE IF NOT EXISTS #{sequence_name}")

        # idカラムにシーケンスを設定
        execute("ALTER TABLE #{table_name} ALTER COLUMN id SET DEFAULT nextval('#{sequence_name}')")
        
        # シーケンスをidカラムに紐づけ
        execute("ALTER SEQUENCE #{sequence_name} OWNED BY #{table_name}.id")
        
        puts "Auto-increment sequence set for #{table_name}.id"
      end
    else
      Rails.logger.info("This migration is intended for PostgreSQL only.")
    end
  end
end