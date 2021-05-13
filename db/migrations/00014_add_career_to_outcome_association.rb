Sequel.migration do
    up do
        alter_table :careers do
          add_foreign_key :outcome_id, :outcomes
        end
    end



    down do
        alter_table :careers do
            drop_foreign_key :outcome_id
        end
    end

end
