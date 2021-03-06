class OrdersController < ApplicationController
  def display
    @order = Order.find_by_confirmation_hash(params[:confirmation_hash])
  end

  def show
    @order = Order.find(params[:id])
    authorize! :manage, Order

    render :show
  end

  def change_status
    order = Order.find(params[:id])
    order.update_status(params[:status])
    redirect_to :back
  end

  def new
    @store_id = params[:store_id]

    cart = current_session.carts.find_by_store_id(@store_id)

    if cart
      if cart.calculate_total_cost <= 50
        flash[:error] =
          "Sorry. Your cart must contain at least $0.51 worth of goods."
        redirect_to root_path and return
      end
    end
      @order = Order.new
      authorize! :create, Order

      render :new
  end

  def edit
    @order = Order.find(params[:id])
    authorize! :update, Order
  end

  def create

    unless params[:user_email] || current_user
      render action: "new", notice: "Please enter an email or log in."
      return
    end

    cart = find_cart(params[:order][:store_id])
    new_order_user = order_user(params[:user_email])

    if cart
      @order = OrderProcessor.process_order(params, cart, new_order_user)

      if @order.valid?
        OrderProcessor.finalize_order_process(cart, new_order_user,
                                            @order, current_session)
        redirect_to display_path(@order.confirmation_hash),
                        notice: 'Thanks! Your order was submitted.'
      end
    else
      render action: "new"
    end
  end

  def update
    @order = Order.find(params[:id])

    if @order.update_attributes(params[:order])
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      render action: "edit"
    end
  end

  private

  def find_cart(store_id)
    current_session.carts.find_by_store_id(store_id)
  end

  def order_user(email)
    current_user || User.find_by_email(email) || User.create_guest_user(email)
  end
end
