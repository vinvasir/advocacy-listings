class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :validatable

  include PolicyManager::Concerns::UserBehavior

  has_many :submitted_organizations, class_name: "Organization", foreign_key: "user_id", dependent: :nullify
  has_many :claims
  has_many :claimed_organizations, through: :claims, source: :organization

  has_many :favorites
  has_many :favorite_organizations, through: :favorites, source: :favoritable, source_type: "Organization"

  def claim(organization)
    claimed_organizations << organization
  end

  def favorite(organization)
    favorite_organizations << organization
  end

  def is_admin?
    email == "prat.vasireddy@gmail.com"
  end
end
