class ClassroomStudent < ApplicationRecord
  belongs_to :student
  belongs_to :classroom
  belongs_to :district
end
