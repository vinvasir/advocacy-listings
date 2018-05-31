class Area < ApplicationRecord
  has_ancestry

  include Slugable  

  after_initialize :set_prefixed_slug

  validates_presence_of :name, :slug
  validates_uniqueness_of :slug
end
