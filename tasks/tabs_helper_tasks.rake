
namespace :js_tabs_helper do
  
  desc 'Copy default js_tabs_helper stylesheet in to your stylesheets directory'
  task :copy_css do
    original = "#{ File.dirname(__FILE__) }/../assets/js_tabs_helper.css"
    copy     = "#{ RAILS_ROOT }/public/stylesheets/js_tabs_helper.css"
    next puts("js_tabs_helper.css was not copied because allready exists") if File.exists? copy
    `cp #{original} #{copy}`
  end

  desc 'Copy default js_tabs_helper javascript in to your javascripts directory'
  task :copy_js do
    original = "#{ File.dirname(__FILE__) }/../assets/js_tabs_helper.js"
    copy     = "#{ RAILS_ROOT }/public/javascripts/js_tabs_helper.js"
    next puts("js_tabs_helper.js was not copied because allready exists") if File.exists? copy
    `cp #{original} #{copy}`
  end
  
end
