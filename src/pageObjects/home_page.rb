require 'rspec'
require 'selenium-webdriver'
require_relative '../../src/pageObjects/abstract_page.rb'
require_relative '../../src/pageObjects/login_page.rb'
require_relative '../../src/pageObjects/product_search_page.rb'

class HomePage < AbstractPage

    def initialize (driver)
        super(driver)
    end

    def confirmPage
        @@driver.title.should == 'n11.com - Alışverişin Uğurlu Adresi'
        @@driver.current_url.should == 'https://www.n11.com/'
        return HomePage.new(@@driver)
    end

    def navigateToLogin
        @@driver.find_element(:class, 'btnSignIn').click
        return LoginPage.new(@@driver)
    end

    def fillInSearch(query)
        @@driver.find_element(:id, 'searchData').send_keys query
        return HomePage.new(@@driver)
    end

    def submitSearch
        @@driver.find_element(:class, 'searchBtn').click
        return ProductSearchPage.new(@@driver)
    end
    

end