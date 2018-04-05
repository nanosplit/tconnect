class Student < ApplicationRecord
  has_many :school_students
  has_many :schools, through: :school_students

  has_many :classroom_students
  has_many :classrooms, through: :classroom_students
  has_many :districts, through: :classroom_students

  has_many :teacher_students
  has_many :teachers, through: :teacher_students

  has_many :student_guardians
  has_many :guardians, through: :student_guardians
end
