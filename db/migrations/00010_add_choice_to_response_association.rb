Sequel.migration do
    up do
        alter_table :choices do
            add_foreign_key :response_id, :responses
        end
    end



    down do
        alter_table :choices do
            drop_foreign_key :response_id
        end
    end

end
