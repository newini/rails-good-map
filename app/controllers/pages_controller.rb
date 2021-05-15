class PagesController < ApplicationController
  def home
    logger.info('hogehogehoge')
    places = get_places(35.6681625, 139.6007829, 'school')
    @place_lat_lng_arr = places.map{ |p| {lat: p['geometry']['location']['lat'], lng: p['geometry']['location']['lng']} }
    logger.info(@place_lat_lng_arr)
  end


  private

    def get_places(lat, lng, keyword)
      #uri = URI.parse("https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input="+keyword+"&inputtype=textquery&fields=photos,formatted_address,name,rating,opening_hours,geometry&key="+Rails.application.credentials.GOOGLE_API_KEY)
      uri = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json")
      params = {
        location: "#{lat},#{lng}",
        radius: 1000, # in m
        keyword: keyword,
        key: Rails.application.credentials.GOOGLE_API_KEY
      }
      uri.query = URI.encode_www_form(params)

      req = Net::HTTP::Post.new(uri.request_uri, 'Content-Type': 'application/json')

      http = Net::HTTP.new(uri.host, uri.port)

      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      res = http.request(req)

      if res.body.nil? || res.body == "[]"
        return []
      else
        res_json = JSON.parse(res.body)
        logger.info(res_json)
        logger.info(res_json['results'])
        return res_json['results']
      end
    end


end
