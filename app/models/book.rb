class Book < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2 }
  validates :genre, presence: true, length: { minimum: 2 }
  validates :current_page, presence: true, numericality: { only_integer: true }
  validates :total_pages, numericality: { only_integer: true }

  belongs_to :author
end
