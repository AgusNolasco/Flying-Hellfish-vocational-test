Sequel.migration do
    up do
        alter_table :careers do
            add_foreign_key :survey_id, :surveys
        end
    end



    down do
        alter_table :careers do
            drop_foreign_key :survey_id
        end
    end

end
