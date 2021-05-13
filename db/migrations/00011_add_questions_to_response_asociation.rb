Sequel.migration do
    up do
        alter_table :questions do
            add_foreign_key :response_id, :responses
        end
    end



    down do
        alter_table :questions do
            drop_foreign_key :response_id
        end
    end

end