class PlantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :rescue_from_response

  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = find_plant
    # plant = Plant.find(params[:id])
    render json: plant
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end


  #  # PATCH /plants/:id
  #  def update
  #   plant = Plant.find_by(id: params[:id])
  #   plant.update(plant_params) #I think it has to do with the params { is_in_stock: false }
  #   render json: plant
  # end

  # # DELETE /plants/:id
  # def destroy
  #   plant = Plant.find_by(id: params[:id])
  #   plant.destroy
  #   head :no_content
  # end

  # ALI SOLUTION BELOW----
  # PATCH /plants/:id

  def change 
    plant = find_plant
      plant.update(plant_params)
      render json: plant
  end

  # DELETE /plants/:id

  def destroy
    plant = find_plant
    plant.destroy
    head :no_content
  end

  private

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end

  def find_plant
    Plant.find(params[:id])
  end

  def rescue_from_response
    render json: plant, status: :not_found
  end

end
