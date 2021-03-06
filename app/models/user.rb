class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
    end
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def self.ordered_by(sort, asc)
    case sort
    when :email
      order{ email.send(asc) }
    when :created
      order{ created_at.send(asc) }
    when :updated
      order{ updated_at.send(asc) }
    else
      all
    end
  end

  scope :similar_emails, -> (partial) { partial.blank? ? all : where{ email =~ "%#{partial}%" } }

  
end
