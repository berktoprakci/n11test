require 'rspec/expectations'
require 'selenium-webdriver'
#require 'capybara'
require_relative '../../src/pageObjects/abstract_page.rb'
require_relative '../../src/pageObjects/my_favorites_page.rb'

class WishlistPage < AbstractPage
    
    def initialize (driver, selectedProductId)
        super(driver)
        @selectedProductId = selectedProductId
    end

    def openMyFavorites
        @@driver.find_element(:css, 'ul .listItemProductList li a').click
        return MyFavoritesPage.new(@@driver, @selectedProductId)
    end

end