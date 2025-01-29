module Jekyll
    class secureblue < Converter
        priority :normal

        def matches(ext)
            ext =~ /^\.md$/i
        end

        def output_ext(ext)
            ".html"
        end

        def convert(content)
            # Seeks tables of contents and wraps them in <nav> elements
            content = content.gsub(%r{(#+)\s+(.+)\s*\{:\s+#table-of-contents\}}) do |match|
                level = $1.length
                text = $2
                id = "table-of-contents"
                "<nav><h#{level} id=\"#{id}\"><a href=\"##{id}\">#{text}</a></h#{level}></nav>"
            end

            # Seeks every heading with a custom ID and wraps them in a self-referential anchor link
            content = content.gsub(%r{(#+)\s+(.+)\s*\{:\s+#([^\}]+)\}}) do |match|
                level = $1.length
                text = $2
                id = $3
                "<h#{level} id=\"#{id}\"><a href=\"##{id}\">#{text}</a></h#{level}>"
            end

            # Seeks every heading without a custom ID and wraps them in a self-referential anchor link
            content = content.gsub(%r{^(#+)\s+(.+)\s$^((?!\s*\{:\s+#))$}) do |match|
                level = $1.length
                text = $2
                id = $2.downcase.gsub(/\s+/, "-")
                "<h#{level} id=\"#{id}\"><a href=\"##{id}\">#{text}</a></h#{level}>"
            end
        end
    end
end
