# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :bigint(8)        not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("Pending"), not null
#

class CatRentalRequest < ApplicationRecord
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: {in: ['Pending', 'Approved', 'Denied'], message: "%{value} is not valid" }
  validate :does_not_overlap_approved_request
  
  belongs_to :cat, 
    foreign_key: :cat_id, 
    class_name: :Cat
  
    def overlapping_requests
      
      requests = CatRentalRequest
        .where("cat_id = ?", cat_id)
        .where("start_date BETWEEN ? AND ? OR end_date BETWEEN ? AND ?", start_date, end_date, start_date, end_date)
      requests
    end
    
    def overlapping_approved_requests 
      overlapping = overlapping_requests.where("status = 'Approved'")
      overlapping
    end
    
    def does_not_overlap_approved_request
      if overlapping_approved_requests.exists?
        errors[:status] << "Cat not available"
      end
    end
end
  
