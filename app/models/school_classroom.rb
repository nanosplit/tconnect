class SchoolClassroom < ApplicationRecord
  belongs_to :district
  belongs_to :school
  belongs_to :teacher
  belongs_to :classroom
end
