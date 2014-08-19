class Product < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :cost, numericality: { greater_than: 0 }

  def self.ordered_by(sort, asc)
    case sort
    when :name
      order{ name.send(asc) }
    when :description
      order{ description.send(asc) }
    when :cost
      order{ cost.send(asc) }
    when :created
      order{ created_at.send(asc) }
    when :updated
      order{ updated_at.send(asc) }
    else
      all
    end
  end

  scope :similar_names, -> (partial) { partial.blank? ? all : where{ name =~ "%#{partial}%" } }
  scope :similar_descriptions, -> (partial) { partial.blank? ? all : where{ description =~ "%#{partial}%" } }
end
 