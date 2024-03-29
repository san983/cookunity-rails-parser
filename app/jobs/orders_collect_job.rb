class OrdersCollectJob < ApplicationJob
  queue_as :orders_collect

  # TODO
  # Clean this up into proper concerns / utility classes
  def perform(*args)
    return unless args && args.first
    seamless_user = args.first.to_i

    seamlessData = SeamlessData.new(seamless_user)
    seamless_user_id = seamlessData.seamless_user_id

    text = "**** Processing a job for #{seamlessData.username} at #{DateTime.now} - OrdersCollectJob #{seamless_user}\n ****"
    logger.info text

    # Create a new mechanize object
    mech = Mechanize.new
    mech.log = Logger.new $stderr
    mech.agent.http.debug_output = $stderr
    mech.user_agent_alias = ["Linux Firefox", "Mac Mozilla", "Mac Safari"].sample

    # Login into Seamless
    page = mech.get(seamlessData.loginUrl)

    return unless page.respond_to?(:forms)

    login_form = page.forms[0]
    login_form["UserName"] = seamlessData.username
    login_form["Password"] = seamlessData.password
    login_form.submit

    # Go to Old Orders Page
    old_orders_page = mech.get(seamlessData.oldOrdersUrl)

    # Parse links
    links = old_orders_page.links

    # Save the new ones into the database

    # TODO
    # Make a bulk insert here
    order_links(links).each do |order_link|
      order = Order.find_or_initialize_by(order_number: order_link.text)
      next unless order.new_record?

      order.account = seamlessData.username
      order.parsed = false
      order.order_date = DateTime.now
      order.link_info = parse_link_info(order_link.href)

      OrdersDetailsCollectJob.perform_now(seamless_user_id, order.id) if order.save
    end
  end

  private

  # TODO
  # Move to LinkInfo model
  def parse_link_info(href)
    res = /\((.*?)\)/.match(href)[1].delete("'").split(',').map(&:strip)
    link_info = LinkInfo.new
    link_info.auto_print = ActiveRecord::Type::Boolean.new.cast(res[1].downcase)
    link_info.vendor_location_id = res[2].to_i
    link_info.token = res[3].to_s
    link_info
  end

  def order_links(links)
    links.select do |link|
      link.text.is_i?
    end
  end

  def order_id
    self.text
  end
end

# TODO
# Move this to a proper place
class String
  def is_i?
    /\A[-+]?\d+\z/ === self
  end
end
