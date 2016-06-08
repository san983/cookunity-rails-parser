require 'rails_helper'

RSpec.describe OrdersDetailsCollectJob, type: :job do
  it "matches with enqueued job" do
    ActiveJob::Base.queue_adapter = :test
    expect {
      OrdersDetailsCollectJob.perform_later
    }.to have_enqueued_job(OrdersDetailsCollectJob)
  end
end
