class MessageInvoice < ApplicationRecord
  belongs_to :message_invoiceable, polymorphic: true
  belongs_to :payer, polymorphic: true
  belongs_to :message
end
