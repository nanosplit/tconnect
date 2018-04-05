class SchoolStudent < ApplicationRecord
  belongs_to :student
  belongs_to :school
  belongs_to :district
end
