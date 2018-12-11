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
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

  end

end
