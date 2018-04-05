class CreateClassroomStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :classroom_students do |t|
      t.references :district, foreign_key: true
      t.references :school, foreign_key: true
      t.references :student, foreign_key: true
      t.references :classroom, foreign_key: true

      t.timestamps
    end
  end
end
