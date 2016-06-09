class StatusController < ApplicationController
  def show
    render plain: ActiveRecord::Migrator.current_version.to_s
  end

  def nothing
    render_not_found
  end
end
