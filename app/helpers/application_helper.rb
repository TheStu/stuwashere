module ApplicationHelper
  def full_title(page_title) #Returns the full title on a per-page basis.
    base_title = "Stu Was Here"
    if page_title.empty?
      base_title
    elsif page_title == "home"
      "#{base_title} | Live Vicariously Through Me"
    else
      "#{page_title} | #{base_title}"
    end
  end

  def meta_desc(desc) #Returns the full title on a per-page basis.
    if desc.empty?
      "Trip reports and preparations, gear reviews, gear lists and plenty of pictures"
    else
      desc
    end
  end

  def pretty_date(date)
    date = date.to_date
    new_date = date.strftime("%b #{date.day.ordinalize}, %Y")
  end

  def flash_class(level) #change rails alerts in to bootstrap alerts (associated partial and application.html code)
   case level
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-error"
    when :alert then "alert alert-error"
    end
  end

  def convert_to_kilograms(amount)
    amount / 1000.to_f
  end

  def next_trip
    next_trip = Trip.first
    Trip.find_each do |trip|
      end_date = end_date_to_date(trip)
      if (end_date - Time.now) > 0 && (end_date - Time.now) < (end_date_to_date(next_trip) - Time.now)
        next_trip = trip
      end
    end
    return next_trip
  end

  def last_trip
    last_trip = Trip.first
    Trip.find_each do |trip|
      end_date = end_date_to_date(trip)
      if (Time.now - end_date) > 0 && (Time.now - end_date) < (Time.now - end_date_to_date(last_trip))
        last_trip = trip
      end
    end
    return last_trip
  end

  def end_date_to_date(trip)
    dated = trip.end_date.split('-').reverse
    Time.new(dated.first, dated.second, dated.third)
  end

  def av_name(avantlink)
    brand_t = avantlink.brand_name.titleize
    product_t = avantlink.product_name.titleize
    product_t = product_t.gsub(/[:;?]/,'')
    if product_t.include? brand_t
      return product_t
    else
      return brand_t + ' ' + product_t
    end
  end
end
