module Jekyll
    # Class names must be constant, that is, starting with an uppercase character :(
    class Secureblue < Converter
        priority :normal

        # Seeks every heading with a custom ID and wraps them in a self-referential anchor link
        def convert_custom_headings(content)
            content.gsub(%r{(#+)\s+(.+)\s*\{:\s+#([^\}]+)\}}) do
                level = $1.length
                text = $2
                id = $3

                "<h#{level} id=\"#{id}\"><a href=\"##{id}\">#{text}</a></h#{level}>"
            end
        end

        # Seeks every heading without a custom ID and wraps them in a self-referential anchor link
        def convert_regular_headings(content)
            content.gsub(%r{(#+)\s+(.+)(.*(?!\n\r?\{.*))}) do
                level = $1.length
                text = $2
                id = $2.downcase.gsub(/\s+/, "-")

                "<h#{level} id=\"#{id}\"><a href=\"##{id}\">#{text}</a></h#{level}>"
            end
        end

        def matches(ext)
            ext =~ /^\.md$/i
        end

        def output_ext(_ext)
            ".html"
        end

        def convert(content)
            content = convert_custom_headings(content)
            convert_regular_headings(content)
        end
    end
end
