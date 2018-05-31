class Category < ApplicationRecord
  has_ancestry

  after_initialize :set_prefixed_slug

  include Slugable
end
