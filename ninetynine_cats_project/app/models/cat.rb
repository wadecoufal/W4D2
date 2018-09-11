require 'action_view'

class Cat < ApplicationRecord 
  include ActionView::Helpers::DateHelper
  
  validates :birth_date, :color, :name, :sex, :description, presence: true
  validate :validate_color, :validate_sex
  
  ALL_COLORS = %w{orange black white calico gray}
  
  def age
    age = time_ago_in_words(birth_date)
  end
  
  def validate_color
    unless ALL_COLORS.include?(color)
      errors[:color] << "Not a valid color"
    end
  end
  
  def validate_sex
    unless ["M","F"].include?(sex)
      errors[:sex] << "Not a valid gender"
    end
  end
end