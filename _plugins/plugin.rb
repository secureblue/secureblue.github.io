module Jekyll
    # Class names must be constant, that is, starting with an uppercase character :(
    class Secureblue < Converter
        priority :normal

        def matches(ext)
            ext =~ /^\.md$/i
        end

        def output_ext(ext)
            ".html"
        end

        def convert(content)
            # Seeks every heading with a custom ID and wraps them in a self-referential anchor link
            content = content.gsub(%r{(#+)\s+(.+)\s*\{:\s+#([^\}]+)\}}) do |match|
                level = $1.length
                text = $2
                id = $3

                "<h#{level} id=\"#{id}\"><a href=\"##{id}\">#{text}</a></h#{level}>"
            end

            # Seeks every heading without a custom ID and wraps them in a self-referential anchor link
            content = content.gsub(%r{(#+)\s+(.+)((?!\{:\s+#))}) do |match|
                level = $1.length
                text = $2
                id = $2.downcase.gsub(/\s+/, "-")

                "<h#{level} id=\"#{id}\"><a href=\"##{id}\">#{text}</a></h#{level}>"
            end
        end
    end
end
