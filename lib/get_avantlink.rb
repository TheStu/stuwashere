module GetAvantlink

  def update_avantlink(gear_item)
    require 'open-uri'
    require 'nokogiri'

    url = "http://www.avantlink.com/api.php?affiliate_id=31645&module=ProductSearch&output=xml&website_id=127225&search_term=#{CGI.escape(gear_item.name)}&search_results_fields=Merchant+Name%7CProduct+Name%7CBrand+Name%7CSale+Price%7CBuy+URL%7C&search_results_count=5&search_results_sort_order=Match+Score%7Cdesc&search_results_options=precise"

    results = Nokogiri::XML(open(url))
    my_hash = results.search('//Table1').map{ |e| Hash.from_xml(e.to_xml)['Table1'] }

    old_avantlinks = gear_item.avantlinks

    my_hash.each do |result|
      av = Avantlink.new(
        gear_item_id: gear_item.id,
        merchant_name: result['Merchant_Name'],
        product_name: result['Product_Name'],
        brand_name: result['Brand_Name'],
        sale_price: result['Sale_Price'],
        buy_url: result['Buy_URL'])
      av.save
    end

    old_avantlinks.destroy
  end
end
