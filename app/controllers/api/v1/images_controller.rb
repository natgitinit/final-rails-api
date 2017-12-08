require 'httparty'
require 'nokogiri'

class Api::V1::ImagesController < ApplicationController

  def index
    images = Image.all

    render json: images
  end

  def scrape
    response = HTTParty.get('https://nytimes.com')
    parse_page = Nokogiri::HTML(response)
    i = 1
    imgs =[]
    while i < 71
      imgs << parse_page.css("body > main > div > article > section > div.sources-container.row > div:nth-child(#{i}) > a > img")
      i += 1
    end
    imgs.flatten.map do |img|
      Image.create(name: img.attributes['alt'].value, image_url: img.attributes['image_url'].value)
    end
  end

  def fetch_sources_from_api
    response = HTTParty.get("https://api.nytimes.com/svc/topstories/v2/arts.json?api-key=#{ENV['NEWS_API_KEY']}")
    response['sources'].map do |source|
      Article.create(title: article['title'], byline: article['byline'], abstract: article['abstract'], url: article['url'], category: article['category'])
    end
  end


end
