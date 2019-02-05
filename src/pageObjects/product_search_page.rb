require 'rspec/expectations'
require 'selenium-webdriver'
# require 'capybara/rspec'
require_relative '../../src/pageObjects/abstract_page.rb'
require_relative '../../src/pageObjects/wishlist_page.rb'

class ProductSearchPage < AbstractPage
    include RSpec::Matchers
    def initialize (driver, selectedProductId = nil)
        super(driver)
        @selectedProductId = selectedProductId
    end
    
    def confirmSearchResult # refactor it
        query = @@driver.find_element(:id, 'searchData').attribute('value')
        @@driver.find_elements(:partial_link_text, query)
        results = @@driver.find_elements(:css, 'section div ul li div div h3.productName.bold')
        results.any? { |x| x.text.downcase.should include(query) }
        return ProductSearchPage.new(@@driver)
    end

    def changePageNumber(number)
        pages = @@driver.find_elements(:css, '.pagination a')
        pages[number-1].click
        return ProductSearchPage.new(@@driver)
    end

    def confirmPageNumber(number)
        @@driver.find_element(:class, 'currentPage').attribute('value').should == number.to_s
        return ProductSearchPage.new(@@driver)
    end

    def addFavorites(number)
        favorites = @@driver.find_elements(:css, '.textImg.followBtn')
        products = @@driver.find_elements(:css, 'section.resultListGroup div ul li div.columnContent')
        @selectedProductId = products[number-1].attribute('id')
        favorites[number-1].click
        return ProductSearchPage.new(@@driver, @selectedProductId)
    end

    def openWishlists
        hoverMenu = @@driver.find_element(:link_text, 'Hesabım')
        hoverMenu.location_once_scrolled_into_view
        @@driver.action.move_to(hoverMenu).perform
        @@driver.find_element(:partial_link_text, 'İstek Listem / Favorilerim').click
        return WishlistPage.new(@@driver, @selectedProductId)
    end

end