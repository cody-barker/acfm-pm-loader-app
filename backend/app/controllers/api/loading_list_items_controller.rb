  class Api::LoadingListItemsController < ApplicationController
    before_action :set_loading_list_item, only: %i[show update destroy]
    
    def index 
      loading_list_items = LoadingListItem.includes(:loading_list, :item).all
      render json: loading_list_items
    end

    def show
      render json: @loading_list_item
    end

   def create
    loading_list_item = LoadingListItem.create!(loading_list_item_params)
    render json: loading_list_item, status: :created
  end


    def update
      loading_list_item = LoadingListItem.find(params[:id])
      if loading_list_item.update(loading_list_item_params)
        render json: loading_list_item
      else
        render json: loading_list_item.errors, status: :unprocessable_entity
      end
    end

    def destroy
      loading_list_item = LoadingListItem.find(params[:id])
      loading_list_item.destroy
      render json: {}, status: :no_content
    end

    private

    def set_loading_list_item
      @loading_list_item = LoadingListItem.includes(:loading_list, :item).find(params[:id])
    end
    
    def loading_list_item_params
      params.require(:loading_list_item).permit(:loading_list_id, :item_id)
    end

end