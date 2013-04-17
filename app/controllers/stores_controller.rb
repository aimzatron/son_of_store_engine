class StoresController < ApplicationController
  layout "application"

  def show
    @store ||= Store.includes(:categories).find_by_path(params[:store_id])
    if @store && @store.status == "live"
      @user_cart ||= Cart.find_current_cart(session[:user_session_id], @store)
      @categories ||= @store.categories
      @products ||= @store.categories.first.products[0..2]
      render layout: "store"
    elsif @store && @store.status != "live"
      render :text => 'This store is closed for maintenance.', 
             :status => '404'
      return
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def store_listing
    @stores = Store.all
  end

  def new
    @store = Store.new
  end

  def edit
    @store = Store.find(params[:id])
  end

  def pending
    @store ||= Store.find_by_path(params[:path])
    render :pending
  end

  def create
    @store = Store.new(params[:store])
    @store.status = "pending"
    if @store.save
      redirect_to "/stores/pending/#{@store.path}"
    else
      render action: "new"
    end
  end

  def update
    @store = Store.find_by_path(params[:store][:path])
    if @store.update_attributes(params[:store])
      redirect_to store_home_path(@store.path), notice: "The store #{@store.name} was successfully updated. Your store path is #{@store.path}, and your description is #{@store.description}."
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
