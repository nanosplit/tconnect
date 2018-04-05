class StudentGuardian < ApplicationRecord
  belongs_to :student
  belongs_to :guardian
  belongs_to :school
  belongs_to :district
end
