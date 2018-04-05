class CreateDistrictSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :district_schools do |t|
      t.references :school, foreign_key: true
      t.references :district, foreign_key: true

      t.timestamps
    end
  end
end
