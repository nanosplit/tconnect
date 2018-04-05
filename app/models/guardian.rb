class Guardian < ApplicationRecord
  has_many :student_guardians
  has_many :students, through: :student_guardians
  has_many :message_recipients, as: :message_receivable
  has_many :messages, through: :message_recipients
end
