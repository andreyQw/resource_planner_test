# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.references :project, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true
      t.text :note
      t.integer :hours_per_day
      t.datetime :date_from
      t.datetime :date_to

      t.timestamps
    end
  end
end
