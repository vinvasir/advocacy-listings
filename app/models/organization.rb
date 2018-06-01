class Organization < ApplicationRecord
  belongs_to :area
  belongs_to :category

  scope :in_area, -> (area) { where(area_id: area.descendant_ids.push(area.id)) }
  scope :from_category, -> (category) { where(category_id: category.descendant_ids.push(category.id)) }
end
