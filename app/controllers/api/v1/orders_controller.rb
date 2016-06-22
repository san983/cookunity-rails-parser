module Api
  module V1
    class OrdersController < ApiController
      # GET /v1/orders
      def index
        orders = if params[:date].present?
                   Order.from_date(params[:date])
                 else
                   Order.from_today
                 end

        render json: orders
      end

      # GET /v1/orders/:id
      def show
        order = Order.find_by_order_number(params[:id])
        if order
          render json: order
        else
          render plain: 'Not Found', status: :not_found
        end
      end
    end
  end
end
