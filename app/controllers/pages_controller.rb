class PagesController < ApplicationController
  def home
    logger.info('hogehogehoge')
    places = get_places(35.6681625, 139.6007829, 'school')
    @place_lat_lng_arr = places.map{ |p| {lat: p['geometry']['location']['lat'], lng: p['geometry']['location']['lng']} }
    #logger.info(@place_lat_lng_arr)
  end

  def get_places_json()
    lat = params[:lat]
    lng = params[:lng]
    keyword = params[:keyword]
    logger.info(lat)
    logger.info(lng)
    logger.info(keyword)
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
      place_lat_lng_arr = res_json['results'].map{ |p| {lat: p['geometry']['location']['lat'], lng: p['geometry']['location']['lng']} }
      render json: place_lat_lng_arr
    end
  end


  private

    def get_places(lat, lng, keyword)
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
        return res_json['results']
      end
    end


end
