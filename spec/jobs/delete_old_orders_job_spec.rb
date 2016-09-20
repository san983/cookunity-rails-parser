require 'rails_helper'

RSpec.describe DeleteOldOrdersJob, type: :job do
  it "matches with enqueued job" do
    ActiveJob::Base.queue_adapter = :test
    expect {
      DeleteOldOrdersJob.perform_later
    }.to have_enqueued_job(DeleteOldOrdersJob)
  end
end
