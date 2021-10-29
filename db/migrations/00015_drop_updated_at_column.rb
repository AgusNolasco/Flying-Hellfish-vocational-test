# frozen_string_literal: true

Sequel.migration do
  up do
    alter_table :surveys do
      drop_column :updated_at
    end
  end

  down do
    alter_table :surveys do
      add_column :updated_at, DateTime
    end
  end
end
