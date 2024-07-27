class CreateCoursesStudentsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :courses_users do |t|
      t.references :course, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
