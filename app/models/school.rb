# == Schema Information
#
# Table name: schools
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  location    :string
#  category    :string
#  logo        :string
#  reviews     :integer          default(0)
#  min_age     :integer
#  max_age     :integer
#  cover       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  bg_img      :string
#  phone       :string
#  website     :string
#  latitude    :float
#  longitude   :float
#
# Indexes
#
#  index_schools_on_user_id  (user_id) UNIQUE
#

class School < ActiveRecord::Base
	include PgSearch

  self.per_page = 5

  mount_uploader :logo, AvatarUploader
  mount_uploader :bg_img, AvatarUploader

  has_many :events, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  validates :category, :inclusion => {:in => ['Private', 'Public', 'International'], :allow_nil => true}

  validates_uniqueness_of :user
  
  geocoded_by :location  
  after_validation :geocode 



  pg_search_scope :pg_address, :against => :location, using: { :tsearch => {:prefix => true, :any_word => true} }

  scope :by_address, -> (query) {
  	return all unless query.present?
  	pg_address(query)
  }
  scope :by_age, -> (min_age, max_age){
  	return all unless min_age.present? && max_age.present?
  	where.or(:min_age => min_age..max_age, :max_age => min_age..max_age)
    # where("(min_age between 2 and ? and max_age between ? and 19) ",min_age,max_age,min_age,max_age,max_age,min_age,max_age)
    # where("(min_age between 2 and ? and max_age between ? and 19) or (min_age between ? and ?)",min_age,max_age,min_age,max_age)

  }

  scope :by_category, -> (category){
  	return all unless category.present?
  	where(:category => category.capitalize)
  }
  scope :by_review, -> { order(reviews: :desc) }

  scope :by_location, -> (lat, long){
    return all unless lat.present? && long.present?
    near([lat.to_f, long.to_f], 20)
  }
  def self.filters search_params
  	by_address(search_params[:location])
  	.by_age(search_params[:min_age], search_params[:max_age])
    .by_category(search_params[:category])
    .by_location(search_params[:lat], search_params[:long])
  end

  def profile_pic
    if self.logo.file.present?
      self.logo.thumbnail.url
    else
      nil
    end
  end

  def logo_pic
    if self.logo.file.present?
      self.logo.thumbnail_saml.url
    else
      nil
    end
  end

  def profile_cover
    if self.bg_img.file.present?
      self.bg_img.cover.url
    else
      nil
    end
  end

  def age_range
    "#{min_age} - #{max_age}"
  end

  def email
    user.email
  end

end















