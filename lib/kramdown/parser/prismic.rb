module Kramdown
  module Parser
    class Prismic < Base
      def parse
        @root.options[:encoding] = 'utf-8'
        return if source.empty?
        text = source.first[:content][:text]

        case source.first[:type]
        when /heading([1-6])/
          add_header_child($1.to_i, text)
        end
      end

      def add_header_child(level, text)
        header = Kramdown::Element.new(:header, nil, nil, {level: level, raw_text: text})
        header.children << Kramdown::Element.new(:text, text)
        @root.children << header
      end
    end
  end
end
