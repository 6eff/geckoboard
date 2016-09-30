Sequel.migration {
  up do
    create_table(:archives) do
      primary_key :id
      Timestamp :timestamp, null: false
      String :response, null: false
    end
      execute <<-SQL
        CREATE extension IF NOT EXISTS hstore
      SQL
  end

  down do
    drop_table(:archives)
  end
}
