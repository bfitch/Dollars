class User < ActiveRecord::Base
  belongs_to :account
  has_many :categories
  has_many :transactions

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, uniqueness: true
end
