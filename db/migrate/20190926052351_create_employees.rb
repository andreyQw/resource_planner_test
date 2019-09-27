# frozen_string_literal: true

class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :name, null: false
      t.string :last_name, null: false
      t.integer :position

      t.timestamps
    end
  end
end
