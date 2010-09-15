module StaticPagesHelper

  def locales(&block)
    if @static_page and @static_page.version_of
      locales_iterator do |item|
        if alternative_page = StaticPage.find_by_version_of_id_and_locale(@static_page.version_of, item[:locale].to_s)
          item[:path_to_set] = set_locale_path(:locale => item[:locale], :return => static_page_path(alternative_page))
        end
        block.call item
      end
    else
      locales_iterator(&block)
    end
  end

  def sanitize_static_content(content)
    tokenizer = HTML::Tokenizer.new(content)
    output = ''
    while token = tokenizer.next

      if token[0,1] != "<"
        output << escape_once(token)
        next
      end

      # Extract HTML tag and attributes
      html_tag = nil
      attributes = {}
      if token =~ /\A<(\/?\w+)(?:\s+(.*))?\s*>\Z/
        html_tag = $1
        if $2
          $2.scan(/(\w+)\s*=["'](.*?)["']/).each {|name, value| attributes[name] = value }
        end
      end

      if not html_tag.nil?
        case html_tag.downcase
          when "img"
            output << %[<img src="#{escape_once attributes["src"]}" alt="" />]

          when "a"
            output << %[<a href="#{escape_once attributes["href"]}" rel="nofollow">]

          when "br", "hr"
            output << "<#{html_tag} />"

          when "b", "strong"
            output << "<strong>"

          when "/b", "/strong"
            output << "</strong>"

          when "i", "em"
            output << "<em>"

          when "/i", "/em"
            output << "</em>"

          when "u"
            output << %[<span style="text-decoration: underline;">]

          when "div", "p"
            added_attr = ''
            if align = attributes["align"] and %w(right center left).include?(align)
              added_attr = " style=\"text-align: #{align}\""
            end
            output << "<p#{added_attr}>"

          when "div", "p"
            output << "</p>"

          when "s", "strike"
            output << %[<span style="text-decoration: line-through;">]

          when "/s", "/strike", "/u"
            output << %[</span>]

          when "/a", "ul", "/ul", "ol", "/ol", "li", "/li", "h2", "/h2", "h3", "/h3"
            output << "<#{html_tag}>"

          end
        end

    end
    output.html_safe
  end

end
