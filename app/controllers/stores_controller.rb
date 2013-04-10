class StoresController < ApplicationController
  def index
    @stores = Store.all
  end

  def show
    @store = Store.find_by_path(params[:store_id])
    @categories = Category.where(store_id: @store.id)
    @products = Product.where(store_id: @store.id).shuffle[0..2]
  end

  def new
    @store = Store.new
  end

  def edit
    @store = Store.find(params[:id])
  end

  def create
    @store = Store.new(params[:store])
    if @store.save
      redirect_to @store, notice: 'Store was successfully created.'
    else
      render action: "new"
    end    
  end

  def update
    @store = Store.find(params[:id])
    if @store.update_attributes(params[:store])
      redirect_to @store, notice: 'Store was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @store = Store.find(params[:id])
    @store.destroy
    redirect_to stores_url
  end
end
