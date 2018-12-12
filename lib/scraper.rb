require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    all_students = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".student-card a").each do |student|
      student_name = student.css(".student-name").text
      student_location = student.css(".student-location").text
      profile_url = student.attributes["href"].value

    all_students <<   { :name => "#{student_name}" , :location =>
    "#{student_location}", :profile_url => "#{profile_url}"

      }
    end
    all_students

  end

  def self.scrape_profile_page(profile_url)
    student = {}
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_links = doc.css(".social-icon-container").children.css('a').map {|link| link['href']}
    student_links.each do |link|
      if link.include?("twitter")
      student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?('github')
        student[:github] = link

      else
        student[:blog] = link
      end

    end
    student[:profile_quote] = doc.css(".profile-quote").text if doc.css(".profile-quote")
    student[:bio] = doc.css('.description-holder').children.css('p').text
      student
  end

end
