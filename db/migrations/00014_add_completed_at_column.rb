Sequel.migration do
    up do
        alter_table :surveys do
            add_column :completed_at, Date
        end
    end

    down do
        alter_table :surveys do
            drop_column :completed_at
        end
    end

end
