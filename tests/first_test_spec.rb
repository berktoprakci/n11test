require 'rspec'
require 'selenium-webdriver'
require_relative '../src/pageObjects/home_page.rb'


describe 'Testing the n11.com search fucntions & favorites list functions' do

    app = nil

    before(:each) do
        options = Selenium::WebDriver::Firefox::Options.new
#        options.add_argument('--headless')
        options.add_argument('--kiosk')
        app = AbstractPage.new(Selenium::WebDriver.for(:firefox, options: options))
    end

    after(:each) do
        app.quit
    end

    it 'add a item from product search page to favorites and after delete it' do
        
        page = app
        .navigateToAppRoot
        .confirmPage
        .navigateToLogin
            .fillInEmail('berktoprakci@gmail.com')
            .fillInPassword('Test1ngpass')
        .submitForm
            .fillInSearch('samsung')
        .submitSearch
        .confirmSearchResult
        .changePageNumber(2)
        .confirmPageNumber(2)
        .addFavorites(3)
        .openWishlists
        .openMyFavorites
        .confirmFavoriteProduct
        .deleteFromMyFavorites
        .confirmItemDelete

    end

end