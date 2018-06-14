class Claim < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  validates_presence_of :application
end
