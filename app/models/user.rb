class User < ActiveRecord::Base
  acts_as_authentic

  has_many :favorites, :dependent => :destroy
  has_many :activities, :dependent => :destroy

  def favors?(resource)
    favorite(resource).present?
  end

  def favor(resource)
    unless favors?(resource)
      favorite = Favorite.new
      favorite.resource = resource
      favorite.user = self
      favorite.domain = domain
      favorite.save
    end
  end

  def unfavor(resource)
    favorite(resource).try(:destroy)
  end

  def favorite(resource)
    favorites.where(:resource_type => resource.class, :resource_id => resource.id).first.presence
  end

  def name
    "#{first_name} #{last_name}".presence || login
  end
  
  belongs_to :domain
end
