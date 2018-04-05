class SchoolTeacher < ApplicationRecord
  belongs_to :school
  belongs_to :teacher
  belongs_to :district
end
