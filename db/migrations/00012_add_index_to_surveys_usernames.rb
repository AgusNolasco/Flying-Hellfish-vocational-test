Sequel.migration do
  up do
    alter_table :surveys do
      add_index :username
    end
  end

  down do
    alter_table :surveys do
      drop_index :username
    end
  end

end
