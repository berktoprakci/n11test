require 'rspec'
require 'selenium-webdriver'
require_relative '../../src/pageObjects/home_page.rb'

class AbstractPage
    

    @@driver = nil
    

    def initialize (driver)
        @@driver = driver
        @@driver.manage.timeouts.implicit_wait = 10
    end

    def navigateToAppRoot
        @@driver.navigate.to('https://www.n11.com')
        return HomePage.new(@@driver)
    end

    def quit
        @@driver.quit
    end

    def getPageTitle
        return @@driver.title
    end


end