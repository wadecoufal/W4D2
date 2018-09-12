class CatRentalRequestsController < ApplicationController
  
  def new
    render :new
  end
  
  def create
    @cat_rental_request = CatRentalRequest.new(cat_request_params)
    
    if @cat_rental_request.save
      redirect_to cat_url(@cat_rental_request.cat_id)
    else
      render @cat_rental_request.errors.full_messages
    end
  end
  
  private
  def cat_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end