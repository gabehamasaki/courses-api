class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :description
      t.references :teacher, null: false, foreign_key: { to_table: :users }
      t.integer :value

      t.timestamps
    end
  end
end
