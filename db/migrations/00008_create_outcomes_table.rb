# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:outcomes) do
      primary_key   :id
      foreign_key   :career_id, :careers
      foreign_key   :choice_id, :choices
      DateTime      :created_at,   default: Sequel::CURRENT_TIMESTAMP
      DateTime      :updated_at,   default: Sequel::CURRENT_TIMESTAMP
    end
  end

  down do
    drop_table(:outcomes)
  end
end
