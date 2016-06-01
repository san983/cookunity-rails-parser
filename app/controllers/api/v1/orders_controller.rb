module Api
  module V1
    class OrdersController < ApiController
      # GET /v1/orders
      def index
        render json: Order.all
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
