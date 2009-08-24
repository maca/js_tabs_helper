begin
  require File.dirname(__FILE__) + '/../../../../spec/spec_helper'
rescue LoadError
  puts "You need to install rspec in your base app"
  exit
end

module Maca::JSTabsHelper
  def concat str; str; end
end


describe Maca::JSTabsHelper, :type => :helper do
  
  it "should wrap in div" do
    result = helper.js_tabs {}
    result.should have_tag('div.tabbed')
  end
  
  it "should add custom class" do
    result = helper.js_tabs( :id => 'mydiv', :class => 'myclass' ){}
    result.should have_tag('div#mydiv.tabbed.myclass')
  end
  
  it "should add a div for each tab" do
    result = helper.js_tabs( :id => 'mydiv', :class => 'myclass' ) do
      helper.tab :es do
      end
      helper.tab :en do
      end
    end
    result.should have_tag('div>div#es')
    result.should have_tag('div>div#en')
  end
  
  it "should render tab content" do
    result = helper.js_tabs( :id => 'mydiv', :class => 'myclass' ) do
      helper.tab :es do
        "<p></p>"
      end
      helper.tab :en do
        "<p></p>"
      end
    end
    result.should have_tag('div>div#es>p')
    result.should have_tag('div>div#en>p')
  end
  
  it "should add not hide first tab if not specified" do
    result = helper.js_tabs( :id => 'mydiv', :class => 'myclass' ) do
      helper.tab :es do
      end
      helper.tab :en do
      end
    end
    result.should_not have_tag('div>div.tab_content#es[style^=display:none]')
    result.should     have_tag('div>div.tab_content#en[style^=display:none]')
  end
  
  it "should not hide second tab" do
    result = helper.js_tabs( :id => 'mydiv', :class => 'myclass' ) do
      helper.tab :es do
      end
      helper.tab :en, :selected => true do
      end
    end
    result.should     have_tag('div>div.tab_content#es[style^=display:none]')
    result.should_not have_tag('div>div.tab_content#en[style^=display:none]')
  end
  
  it "should hide all but second tab" do
    result = helper.js_tabs( :id => 'mydiv', :class => 'myclass' ) do
      helper.tab :es, :selected => false do
      end
      helper.tab :en, :selected => true do
      end
      helper.tab :fr, :selected => true do
      end
    end
    
    result.should     have_tag('div.tabbed')
    result.should_not have_tag('div.tabbed[style^=display:none]')
    result.should     have_tag('div>div.tab_content#es[style^=display:none]')
    result.should_not have_tag('div>div.tab_content#en[style^=display:none]')
    result.should     have_tag('div>div.tab_content#fr[style^=display:none]')
  end
  

  it "should add tabnav list" do
    result = helper.js_tabs( :id => 'mydiv', :class => 'myclass' ) do
      helper.tab :es, :selected => false do
      end
      helper.tab :en, :selected => true do
      end
      helper.tab :fr, :selected => true do
      end
    end
    
    result.should     have_tag('ul#tabnav>li>a#es_link')
    result.should     have_tag('ul#tabnav>li>a#en_link.selected')
    result.should     have_tag('ul#tabnav>li>a#fr_link')
    result.should_not have_tag('ul#tabnav>li>a#es_link.selected')
    result.should_not have_tag('ul#tabnav>li>a#fr_link.selected')
  end
  
end