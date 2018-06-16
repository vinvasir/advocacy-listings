class Notification < ApplicationRecord
  belongs_to :recipient, class_name: "User"
  belongs_to :actor, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  scope :for, -> (user) { where recipient: user }
  scope :unread, -> { where read_at: nil }
end
