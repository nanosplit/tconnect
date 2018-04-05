class DistrictSchool < ApplicationRecord
  belongs_to :school
  belongs_to :district
end
