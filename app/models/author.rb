class Author < ApplicationRecord
  has_many :articles

  validates :first_name, :last_name, presence: true
end
