require 'carrierwave/orm/activerecord'
class Movie < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  has_many :reviews

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_future

 scope :query_search, -> (query="") { where("title LIKE ? OR director LIKE ?", "%#{query}%", "%#{query}%") if !query.blank? }
 scope :duration_search, -> (duration){
      puts "***********"
      puts duration
      puts "***********"

      case duration 
      when "Under 90"
        where("runtime_in_minutes < ?", 90)
      when "Between 90 and 120"
        where("runtime_in_minutes >= ? AND runtime_in_minutes <= ?", 90, 120)
      when "Over 120"
        where("runtime_in_minutes > ?", 120)
      else
        
      end
 }

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size
  end

  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end

end
