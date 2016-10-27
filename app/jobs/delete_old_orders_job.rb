class DeleteOldOrdersJob < ApplicationJob
  queue_as :delete_orders_collect

  def perform
    logger.info "Processing a job... #{DateTime.now} - DeleteOldOrdersJob"

    old_olders = get_old_orders

    logger.info "Started deleting #{old_olders.count} orders #{old_olders.pluck(:id)} - DeleteOldOrdersJob"
    old_olders.destroy_all
    logger.info "Finished deleting #{old_olders.count} orders - DeleteOldOrdersJob"
  end

  private

  def get_old_orders
    Order.where("created_at < ?", DateTime.now - 2.month)
  end
end
