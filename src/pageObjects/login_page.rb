require 'rspec'
require 'selenium-webdriver'
require_relative '../../src/pageObjects/abstract_page.rb'
require_relative '../../src/pageObjects/home_page.rb'

class LoginPage < AbstractPage

    def initialize (driver)
        super(driver)
    end

    def fillInEmail(email)
        @@driver.find_element(:name, 'email').send_keys email
        return LoginPage.new(@@driver)
    end

    def fillInPassword(password)
        @@driver.find_element(:name, 'password').send_keys password
        return LoginPage.new(@@driver)
    end

    def submitForm
        @@driver.find_element(:id, 'loginButton').click
        return HomePage.new(@@driver)
    end

end