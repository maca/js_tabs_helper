# TabsHelper

module Maca
  module JSTabsHelper
    VERSION = '0.1'
    
    def js_tabs opts = {}, &block
      css_class = opts.delete(:class)
      css_class = css_class ? "tabbed #{css_class}" : "tabbed"
      @_tabs_   = []
      content   = capture(&block).to_s

      selected  = @_tabs_.inject(false) do |sel, tab|
        tab[-1] = false if sel
        tab.last || sel
      end
      @_tabs_[0][-1] = true unless selected if @_tabs_.first
      
      nav       = []
      tabs      = @_tabs_.collect do |tab|
        name        = tab.shift.to_s
        id          = name
        div_opts    = tab.shift
        div_content = tab.shift
        selected    = tab.shift
        
        tab_opts    = {:id => "#{ id }_link", :href => '#'}
        selected ? tab_opts.merge!(:class => 'selected') : div_opts.merge!(:style => 'display:none;')
        
        
        nav.push content_tag( :li, content_tag(:a, name, tab_opts) )
        content_tag :div, div_content, div_opts.merge(:id => id, :class => 'tab_content')
      end.join("\n")
      
      concat content_tag(:div, %{#{ content_tag :ul, nav.join("\n"), :id => 'tabnav' }\n#{ tabs }\n#{ content }}, opts.merge(:class => css_class)).to_s
    end
    
    def tab name, opts = {}, &block
      selected = opts.delete :selected
      @_tabs_.push [name, opts, capture(&block), selected]
    end
  end 
end

ActionController::Base.helper Maca::JSTabsHelper
