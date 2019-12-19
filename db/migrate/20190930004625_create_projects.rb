# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :color, null: false
      t.belongs_to :employee

      t.timestamps
    end
  end
end
