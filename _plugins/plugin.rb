module Jekyll
    class HeadingLinkwrap < Converter
        priority :normal

        def matches(ext)
            ext =~ /^\.md$/i
        end

        def output_ext(ext)
            ".html"
        end

        def convert(content)
            content = content.gsub(%r{(#+)\s+(.+)\s*\{:\s+#table-of-contents\}}) do |match|
                level = $1.length
                text = $2
                id = "table-of-contents-is-this-working"
                "<nav><h#{level} id=\"#{id}\"><a href=\"##{id}\">#{text}</a></h#{level}></nav>"
            end
            
            content = content.gsub(%r{(#+)\s+(.+)\s*\{:\s+#([^\}]+)\}}) do |match|
                level = $1.length
                text = $2
                id = $3
                "<h#{level} id=\"#{id}\"><a href=\"##{id}\">#{text}</a></h#{level}>"
            end
        end
    end
end
