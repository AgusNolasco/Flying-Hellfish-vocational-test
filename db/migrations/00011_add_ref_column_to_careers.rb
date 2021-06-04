Sequel.migration do
    up do
        alter_table :careers do
            add_column :ref, String
        end
    end

    down do
        alter_table :careers do
            drop_column :ref
        end
    end

end
