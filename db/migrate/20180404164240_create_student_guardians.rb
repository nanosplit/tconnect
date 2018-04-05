class CreateStudentGuardians < ActiveRecord::Migration[5.1]
  def change
    create_table :student_guardians do |t|
      t.references :student, foreign_key: true
      t.references :guardian, foreign_key: true
      t.references :school, foreign_key: true
      t.references :district, foreign_key: true

      t.timestamps
    end
  end
end
