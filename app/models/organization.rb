class Organization < ApplicationRecord
  include AlgoliaSearch

  belongs_to :area
  belongs_to :category
  belongs_to :submitter, class_name: "User", foreign_key: "user_id", optional: true

  has_many :favorites, as: :favoritable
  has_many :favoriters, through: :favorites, source: :user
  
  has_many :claims
  has_many :claimants, through: :claims, class_name: "User", source: :user

  has_many :approved_claims, -> { where approved: true }, class_name: "Claim"
  has_many :owners, through: :approved_claims, source: :user

  scope :in_area, -> (area) { where(area_id: area.descendant_ids.push(area.id)) }
  scope :from_category, -> (category) { where(category_id: category.descendant_ids.push(category.id)) }

  scope :live, -> { where(live: true) }
  scope :not_live, -> { where.not(live: true) }

  algoliasearch per_environment: true, unless: :hide_from_algolia?, disable_indexing: Rails.env.test? do
    attribute :id, :title, :mission

    attribute :created_at do
      created_at.strftime("%b %d, %Y")
    end

    attribute :updated_at do
      updated_at.strftime("%b %d, %Y")
    end

    attribute :area do
      { 
        id: area.id, 
        name: area.name, 
        slug: area.slug,
        parent_id: area.parent_id
      }
    end

    attribute :category do
      {
        id: category.id,
        name: category.name,
        slug: category.slug,
        parent_id: category.parent_id
      }
    end
  end

  def hide_from_algolia?
    !self.live?
  end

  def post_read_path_for(user)
    @claim = Claim.where(organization: self, user: user).first

    Rails.application.routes.url_helpers.edit_admin_claim_path(@claim)
  end

  def area_name=(name)
    area = Area.find_by(name: name)

    area = Area.create(name: name) unless !!area
    
    self.area_id = area.id
  end

  def category_name=(name)
    category = Category.find_by(name: name)

    category = Category.create(name: name) unless !!category

    self.category_id = category.id
  end
end
