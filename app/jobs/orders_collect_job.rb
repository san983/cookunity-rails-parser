class OrdersCollectJob < ApplicationJob
  queue_as :default

  def perform(*args)
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
    login_form.submit

    # Go to Old Orders Page
    old_orders_page = mech.get(ENV['SEAMLESS_OLD_ORDERS_URL'])

    # Parse links
    links = old_orders_page.links
    order_links(links).map(&:order_id).uniq.each do |order_number|
      order = Order.find_or_initialize_by(order_number: order_number)
      if order.new_record?
        order.order_date = DateTime.now
        order.save!
      end
    end
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
