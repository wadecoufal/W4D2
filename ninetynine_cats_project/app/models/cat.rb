# == Schema Information
#
# Table name: cats
#
#  id          :bigint(8)        not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'action_view'

class Cat < ApplicationRecord 
  
  ALL_COLORS = %w{orange black white calico gray}
  
  include ActionView::Helpers::DateHelper
  
  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: { in: ALL_COLORS, 
    message: "%{value} is not a valid color"}
  validates :sex, inclusion: { in: ["M", "F"], message: "%{value} is not a valid sex"}
  
  def age
    age = time_ago_in_words(birth_date)
  end
  
  has_many :rental_requests, 
    foreign_key: :cat_id, 
    class_name: :CatRentalRequest,
    dependent: :destroy
end
