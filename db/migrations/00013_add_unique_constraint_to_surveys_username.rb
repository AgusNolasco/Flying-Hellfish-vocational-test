Sequel.migration do

  up do
    alter_table :surveys do
      add_unique_constraint(:username, name: 'unique_username')
    end
  end

  down do
    alter_table :surveys do
      drop_constraint(:unique_username)
    end
  end

end
