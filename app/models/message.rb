class Message < ApplicationRecord
  belongs_to :message_sendable, polymorphic: true
  has_one :message_invoice
  belongs_to :classroom
  has_many :message_recipients
end
