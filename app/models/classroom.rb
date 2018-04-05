class Classroom < ApplicationRecord
  has_many :school_classrooms
  has_many :districts, through: :school_classrooms
  has_many :teachers, through: :school_classrooms
  has_many :schools, through: :school_classrooms

  has_many :classroom_students
  has_many :students, through: :classroom_students

  has_many :messages
end
