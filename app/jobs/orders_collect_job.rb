class OrdersCollectJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later

    # Create a new mechanize object
    mech = Mechanize.new
    mech.log = Logger.new $stderr
    mech.agent.http.debug_output = $stderr
    mech.user_agent_alias = ["Linux Firefox", "Mac Mozilla", "Mac Safari"].sample

    # Login into Seamless
    page = mech.get(ENV['SEAMLESS_LOGIN_URL'])
    login_form = page.forms[0]
    login_form["UserName"] = ENV['SEAMLESS_USER']
    login_form["Password"] = ENV['SEAMLESS_PASSWORD']
    form.submit

    # Go to Old Orders Page
    old_orders_page = mech.get(ENV['SEAMLESS_OLD_ORDERS_URL'])

    # Parse links
    links = old_orders_page.links
    puts order_links(links).map(&:order_id)
  end

  private

  def order_links(links)
    links.select do |link|
      link.text.is_i?
    end
  end

  def order_id
    self.text
  end
end

class String
  def is_i?
    /\A[-+]?\d+\z/ === self
  end
end
