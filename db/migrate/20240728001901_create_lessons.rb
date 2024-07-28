class CreateLessons < ActiveRecord::Migration[7.1]
  def change
    create_table :lessons do |t|
      t.string :name
      t.string :description
      t.integer :order
      t.references :topic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
