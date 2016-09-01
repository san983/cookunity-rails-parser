class OrdersDetailsCollectJob < ApplicationJob
  queue_as :orders_collect

  # TODO
  # Clean this up into proper concerns / utility classes
  def perform(order_id, force_parse = false)
    logger.info "Processing a job... #{DateTime.now} - OrdersDetailsCollectJob"

    order = Order.find_by_id(order_id)
    return if order.nil? || order.link_info.nil?

    unless force_parse
      return if order.parsed?
    end

    # Create a new mechanize object
    mech = Mechanize.new
    mech.log = Logger.new $stderr
    mech.agent.http.debug_output = $stderr
    mech.user_agent_alias = ["Linux Firefox", "Mac Mozilla", "Mac Safari"].sample

    # Login into Seamless
    page = mech.get(order_detail_url(order))

    # return unless page.respond_to?(:forms)

    # meals
    order.meals = []
    page.css(".newitem").each do |item|
      item_details = item.css("td")
      order.meals << parse_item_details(item_details)
    end

    # delivery instructions
    order.delivery_instructions = ""

    page.css("#Table1 div.fontSmallBlackBold p").each do |item|
      order.delivery_instructions << (item.text.strip + " ")
    end

    page.css(".ecotogo").each do |item|
      order.delivery_instructions << (item.text.strip + " ")
    end

    order.delivery_instructions.rstrip!

    # Product Total
    page.css("#ProductTotal").each do |item|
      order.product_total = item&.text&.strip&.to_money
    end

    # Sales Tax
    page.css("#SalesTax").each do |item|
      order.sales_tax = item&.text&.strip&.to_money
    end

    # Tip Amount
    page.css("#TipAmount").each do |item|
      order.tip = item&.text&.strip&.to_money
    end

    # Delivery Fee
    page.css("#DeliveryFee").each do |item|
      order.delivery_fee = item&.text&.strip&.to_money
    end

    # Total Amount
    page.css(".innertable2 .right h3").each do |item|
      order.total = item&.text&.strip&.to_money
    end

    # order date
    item = page.css('.innertable1 td[style*="font-size: 11px !important;"]').first
    order.order_date = parse_order_date(item)

    # user
    phone = page.css('#Table1 .bold strong span[style*="font-size:14px;color:Black;"]').first.text.squish
    full_name = page.css('#Table1 .bold p').first.text.squish
    names = full_name.split(' ')
    order.user = {
      name: full_name,
      first_name: names[0...(names.count-1)].join(' '),
      last_name: names.last,
      phone: phone
    }

    # address
    address_field_size = page.css('#Table1 .bold p').count
    address_field_size = address_field_size == 0 ? 1 : address_field_size

    seamless_address = page.css('#Table1 .bold p')[address_field_size - 1].text
    seamless_address_squished = seamless_address.squish
    company = address_field_size > 2 ? page.css('#Table1 .bold p')[1].text.squish : ""

    zipcode_raw = page.css('#Table1 .bold p').text
    zipcode = "NOZIP"

    if zipcode_raw
      zipcode = zipcode_raw.scan(/[0-9]{5}-[0-9]{4}/).try(:first).try(:to_s)

      unless zipcode
        zipcode = zipcode_raw.scan(/[^0-9][0-9]{5}[^0-9]/).try(:first).try(:to_s)
        zipcode = zipcode.gsub(/\D/, '')
      end
    end

    order.address = {
      seamless_address: seamless_address_squished,
      address: seamless_address.lstrip.split("\r").first,
      address_line_2: /(?<=(Apt\/Flat\/Suite\/Floor #:)).*? \w+/.match(seamless_address_squished).to_s.squish,
      company: company,
      zipcode: zipcode,
      geolocation: 'TODO'
    }

    order.parsed = true
    order.failed_parsing = false
    order.save!
  rescue Error
    order.update_attributes!(failed_parsing: true) if order
  end

  private

  def parse_order_date(item)
    date_in_string = item.text.squish.remove('Order Placed: ')

    Time.zone = "Eastern Time (US & Canada)"
    Time.zone.parse(date_in_string)
  end

  def parse_item_details(item_details)
    obj = item_details.map(&:text).map(&:strip)
    {
      item: obj[1],
      price: obj[2],
      quantity: obj[3].delete("x").strip.to_i,
      total: obj[5]
    }
  end

  def order_detail_url(order)
    user_id = 8_947_152
    "https://www.seamless.com/OrderView.m?orderId=#{order.order_number}&vendorLocationId=#{order.link_info.vendor_location_id}&autoPrint=False&view=internal&viewReceiptFromDetailReport=False&interface=Vendor&userID=#{user_id}&Token=#{order.link_info.token}"
  end
end
