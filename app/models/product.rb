class Product < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :cost, numericality: { greater_than: 0 }
end
 