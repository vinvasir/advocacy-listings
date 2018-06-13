class Organization < ApplicationRecord
  belongs_to :area
  belongs_to :category
  belongs_to :submitter, class_name: "User", foreign_key: "user_id", optional: true

  has_many :favorites, as: :favoritable
  has_many :favoriters, through: :favorites, source: "user_id"

  has_many :claims
  has_many :claimants, through: :claims, class_name: "User", source: :user

  scope :in_area, -> (area) { where(area_id: area.descendant_ids.push(area.id)) }
  scope :from_category, -> (category) { where(category_id: category.descendant_ids.push(category.id)) }

  scope :live, -> { where(live: true) }
  scope :not_live, -> { where.not(live: true) }
end
