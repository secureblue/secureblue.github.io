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
            # Seeks tables of contents and wraps them in <nav> elements
            content = content.gsub(%r{(#+)\s+(.+)\s*\{:\s+#([^\}]+)\}\s((-.+\s)+)}) do |match|
                level = $1.length
                text = $2
                id = $3

                # Logic related to the "list" variable exists because each converter must be wholly
                # responsible for what it intends to process, for what its regex captures, and that
                # includes the list elements of a table of contents here, since they must be wrapped
                # inside a <nav> element too and are captured with the above regex as such
                list = $4.split(/\n+/)
                a = 0
                list.each do |n|
                    n = n.gsub(%r{(-+)\s+\[([^\]]+)\]\(#([^\]]+)\)}) do |match|
                        list_level = $1.length
                        list_text = $2
                        list_id = $3
                        "<li><a href='##{list_id}'>#{list_text}</a></li>"
                    end
                    a = a + 1
                    list[a] = n
                end
                
                list = list.join
            
                "<nav><h#{level} id=\"#{id}\"><a href=\"##{id}\">#{text}</a></h#{level}><ul>" + list + "</ul></nav>"
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
