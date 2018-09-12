class CatsController < ApplicationController
  
  def index 
    @cats = Cat.all 
    render :index
  end
  
  def show
    @cat = Cat.find(params[:id])
    render :show
  end
  
  def new
    @cat = Cat.new 
    render :new
  end
  
  def create 
    @cat = Cat.new(cat_params)
    
    if @cat.save 
      redirect_to cat_url(@cat) 
    else 
      render @cat.errors.full_messages
    end
  end
  
  def edit
    @cat = Cat.find(params[:id])
    render :edit 
  end
  
  def update 
    @cat = Cat.find(params[:id])
    
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat) 
    else
      render :edit
    end
  end
  
  private 
  
  def cat_params 
    params.require(:cat).permit(:name, :sex, :age, :color, :birth_date, :description)
  end
  
end