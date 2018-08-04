module ApplicationHelper
	def markdown(text)
	    options = {
	      hard_wrap: true,
	      filter_html: false
	    }

	    renderer = Redcarpet::Render::HTML.new(options)
	    markdown = Redcarpet::Markdown.new(renderer, options)

	    markdown.render(text).html_safe
  	end
end
