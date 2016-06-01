require 'rails_helper'

RSpec.describe OrdersCollectJob, type: :job do
  it "matches with enqueued job" do
    ActiveJob::Base.queue_adapter = :test
    expect {
      OrdersCollectJob.perform_later
    }.to have_enqueued_job(OrdersCollectJob)
  end
end
