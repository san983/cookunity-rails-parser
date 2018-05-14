module Api::V1
  class CancelMealsController < ApiController
    # POST /api/v1/cancel_meal
    def create
      @cancel_meal = cancel_meal_params

      body = @cancel_meal.to_json

      logger.debug "New cancel meal: #{@cancel_meal.inspect}"

      if cancel_meal_params.has_key?(:meal)
        render json: body, status: :created, location: @cancel_meal
      else
        render json: body, status: :unprocessable_entity
      end
    end

    private

      # Only allow a trusted parameter "white list" through.
      def cancel_meal_params
        params.require(:cancel_meal).permit(:meal)
      end
  end
end
