class Teacher < ApplicationRecord
  has_many :messages, as: :message_sendable
  has_many :message_invoices, as: :message_invoiceable
  has_many :message_recipients, as: :message_receivable
  has_many :message_payers, class_name: 'MessageInvoice', as: :payer

  has_many :school_teachers
  has_many :schools, through: :school_teachers
  has_many :districts, through: :school_teachers

  has_many :school_classrooms
  has_many :classrooms, through: :school_classrooms

  has_many :teacher_students
  has_many :students, through: :teacher_students

  has_many :guardians, through: :students
end
