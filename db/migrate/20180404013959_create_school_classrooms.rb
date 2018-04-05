class CreateSchoolClassrooms < ActiveRecord::Migration[5.1]
  def change
    create_table :school_classrooms do |t|
      t.references :district, foreign_key: true
      t.references :school, foreign_key: true
      t.references :classroom, foreign_key: true
      t.references :teacher, foreign_key: true

      t.timestamps
    end
  end
end
