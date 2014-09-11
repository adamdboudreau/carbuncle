class Note < ActiveRecord::Base
  belongs_to :user

  validates :value, presence: true

  scope :similar_notes, -> (partial) { partial.blank? ? all : where{ value =~ "%#{partial}%" } }

  def self.ordered_by(sort, asc)
    case sort
    when :value
      order{ value.send(asc) }
    when :email
      joins{ user.outer }.order{ user.email.send(asc) }
    when :created
      order{ created_at.send(asc) }
    when :updated
      order{ updated_at.send(asc) }
    else
      all
    end
  end
end
