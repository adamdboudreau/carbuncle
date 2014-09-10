class Painting < ActiveRecord::Base
  validates :title, presence: true
  validates :ordinal, numericality: { greater_than: 0 }, allow_blank: true

  mount_uploader :image, ImageUploader

  before_create :default_title
  
  def default_title
    self.title ||= File.basename(image.filename, '.*').titleize if image
  end

  def self.ordered_by(sort, asc)
    case sort
    when :image
      order{ image.send(asc) }
    when :title
      order{ title.send(asc) }
    when :caption
      order{ caption.send(asc) }
    when :ordinal
      order{ ordinal.send(asc) }
    when :created
      order{ created_at.send(asc) }
    when :updated
      order{ updated_at.send(asc) }
    else
      all
    end
  end

end
