class User < ApplicationRecord
  include PubSub::Emit

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  has_one :vessel
  has_and_belongs_to_many :vessel_groups

  def managed_vessels
    Vessel.includes(vessel_group: :users).where(users: { id: id }).or(Vessel.where(user: self))
  end
end
