Sequel.migration do
  up do
    alter_table :responses do
      add_foreign_key :choice_id, :choices
    end
  end



  down do
    alter_table :responses do
      drop_foreign_key :choice_id
    end
  end

end
