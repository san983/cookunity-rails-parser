class StatusController < ApplicationController
  def show
    render plain: ActiveRecord::Migrator.current_version.to_s
  end
end
