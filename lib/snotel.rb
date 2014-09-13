require 'snotel/version'
require 'snotel/stations'
require 'snotel/tokens'

require 'net/http'
require 'json'
require 'csv'

module Snotel
  def self.get_station_data
    Snotel::Stations::ALL
  end

  def self.get_triplet_from_token(token)
    Snotel::Tokens::TOKENS[token] || raise("Token #{ token } not found.")
  end

  def self.daily(token, readings = 1)
    get_daily_data(get_triplet_from_token(token), readings-1)  # Subtract to account for delta.
  end

  def self.hourly(token, readings = 24)
    get_daily_data(get_triplet_from_token(token), readings-1)  # Subtract to account for delta.
  end

  def self.get_daily_data(triplet, readings)
    get_data(triplet, readings, :daily)
  end

  def self.get_hourly_data(triplet, readings)
    get_data(triplet, readings, :hourly)
  end

  # The majority of this functionality is taken directly from:
  # https://github.com/bobbymarko/powderlines-api
  def self.get_data(triplet, readings, granularity = :daily)
    uri  = build_uri(triplet, readings, granularity)
    json = Net::HTTP.get(uri)

    lines = CSV.parse(remove_comments(json))

    keys  = lines.delete(lines.first).map do |key|
      key.gsub(/[^0-9a-z ]+/i, '').gsub(/ /, '_').downcase.to_sym
    end

    parse_csv_data(keys, lines)
  end

  def self.parse_csv_data(keys, lines)
    lines.map { |values| Hash[keys.zip(values)] }
  end

  def self.build_uri(triplet, readings, granularity = :daily)
    URI(
      "http://www.wcc.nrcs.usda.gov/reportGenerator/view_csv/customSingleStationReport"\
      "/#{granularity}/#{triplet}%7Cid%3D%22%22%7Cname/-#{readings}%2C0/WTEQ%3A%3Avalue%2CWTEQ%3A%3A"\
      "delta%2CSNWD%3A%3Avalue%2CSNWD%3A%3Adelta"
    )
  end

  def self.remove_comments(json)
    json.gsub(/(^#.+|#)/, '').gsub(/^\s+/, "")
  end
end
