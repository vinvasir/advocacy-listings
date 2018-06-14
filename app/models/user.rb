class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :validatable

  include PolicyManager::Concerns::UserBehavior

  has_many :submitted_organizations, class_name: "Organization", foreign_key: "user_id", dependent: :nullify
  has_many :claims
  has_many :claimed_organizations, through: :claims, source: :organization

  def approved_claims
    claims.where(approved: true)
  end

  def own_organizations
    approved_claims.includes(:organization).map(&:organization)
  end

  def pending_claimed_organizations  
    claims.where(approved: false).includes(:organization).map(&:organization)
  end

  has_many :favorites
  has_many :favorite_organizations, through: :favorites, source: :favoritable, source_type: "Organization"

  def claim(organization, application)
    claims.create(organization: organization, application: application)
  end

  def favorite(organization)
    return favorite_organizations << organization unless favorite_organizations.include?(organization)

    false
  end

  def is_admin?
    email == "prat.vasireddy@gmail.com"
  end
end
