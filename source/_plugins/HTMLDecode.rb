require 'cgi'

module Jekyll
  module HTMLdecode
    def decode(text)
      CGI.unescapeHTML(text)
    end
  end
end

Liquid::Template.register_filter(Jekyll::HTMLdecode)