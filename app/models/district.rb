class District < ApplicationRecord
  has_many :district_schools
  has_many :schools, through: :district_schools

  has_many :messages, as: :message_sendable
  has_many :message_invoices, as: :message_invoiceable
  has_many :message_payers, class_name: 'MessageInvoice', as: :payer

  has_many :school_teachers
  has_many :teachers, through: :school_teachers

  has_many :school_classrooms
  has_many :classrooms, through: :school_classrooms

  has_many :school_students
  has_many :students, through: :school_students

  has_many :student_guardians
  has_many :guardians, through: :student_guardians
end
