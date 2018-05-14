module Api::V1
  class OrdersController < ApiController
    # GET /api/v1/orders
    def index
      orders = if orders_params[:date].present?
                 Order.from_date(orders_params[:date])
               else
                 Order.from_today
               end

      render json: orders
    end

    # GET /api/v1/orders/:id
    def show
      order = Order.find_by_order_number(orders_params[:id])
      if order
        render json: order
      else
        render plain: 'Not Found', status: :not_found
      end
    end

    private

      # Only allow a trusted parameter "white list" through.
      def orders_params
        params.permit(:id, :date)
      end
  end
end
