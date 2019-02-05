require 'rspec/expectations'
require 'selenium-webdriver'
# require 'capybara'
require_relative '../../src/pageObjects/abstract_page.rb'

class MyFavoritesPage < AbstractPage
    
    def initialize (driver, selectedProductId)
        super(driver)
        @selectedProductId = selectedProductId
    end

    def confirmFavoriteProduct
        @@driver.find_element(:id, @selectedProductId)
        return MyFavoritesPage.new(@@driver, @selectedProductId)
    end

    def deleteFromMyFavorites
        @@driver.find_element(:css, 'div.wishProBtns span.deleteProFromFavorites').click
        @@driver.find_element(:css, '.btn.btnBlack.confirm').click
        return MyFavoritesPage.new(@@driver, @selectedProductId)
    end

    def confirmItemDelete
        @wait = Selenium::WebDriver::Wait.new(:timeout => 15)
        @wait.until {@@driver.find_element(:css, '.emptyWatchList.hiddentext')}
        begin
            unless @@driver.find_element(:id, @selectedProductId).nil?
                raise 'item is not deleted'
            end
        rescue Selenium::WebDriver::Error::NoSuchElementError
        end
        return MyFavoritesPage.new(@@driver, @selectedProductId)
    end

end