class Author < ApplicationRecord
  validates :first_name, presence: true, length: { minimum: 1 }
  validates :second_name, presence: true, length: { minimum: 1 }
  validates :age, numericality: { only_integer: true }
  validates :bio , presence: true, length: { maximum: 500 }
  validates :publisher , presence: true, length: { minimum: 10 }

  has_many :books
end
