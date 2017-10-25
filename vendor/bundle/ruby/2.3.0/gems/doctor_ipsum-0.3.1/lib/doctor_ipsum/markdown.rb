module DoctorIpsum
  class Markdown < Lorem
    class << self
      # Uses Atx-style i.e. ## Header
      def header(input = nil, level = 1)
        input ||= words
        resolve_md(input, true).prepend('#'*[0,level,6].sort[1]+' ')
      end

      # Uses underscore
      def emphasis(input = nil, level = 1)
        input ||= words
        underscore = '_'*[0,level,2].sort[1]
        resolve_md(input).prepend(underscore).concat(underscore)
      end

      # Simple Blockquote (no Markdown inside...yet)
      def blockquote(input = nil, level = 5)
        input ||= sentences
        [].tap { |x| resolve_md(input).split(' ').each_slice(level) { |s| x << s.join(' ').prepend('> ') } }.join("\n")
      end

      # Uses *
      def list(input = nil, level = 2, ordered = false)
        input ||= words(10)
        [].tap { |x|
          resolve_md(input).split(' ').each_slice(level).with_index { |s,i|
            x << s.join(' ').prepend((ordered ? (i+1).to_s+'.' : '*')+' ')
          }
        }.join("\n")
      end

      # 10 dashes
      def horizontal
        '-'*10
      end

      # Opinionated link format
      def link
        url = (rand(0..1)>0 ? 'google.com' : 'github.com/geekjuice/doctor_ipsum')
        basic_format( nil, url , nil)
      end

      # Images from placehold.it
      def image(width = rand(300..500), height = rand(300..500))
        url = 'placehold.it/'+width.to_s+'x'+height.to_s
        basic_format( nil, url, nil).prepend('!')
      end

      # Random markdown blog entry
      def entry(*args)
        out = []
        allowed = ["header","emphasis","paragraphs","blockquote",
                   "list","link","image"]
        elements = ( args ? allowed : filter(args.flatten,allowed) )
        out << header if elements.include? 'header'
        rand(3..10).times do
          cmd = elements.sample
          out << (cmd == 'image' ? image(500,500) : send(cmd) ) << paragraphs
        end
        out.join("\n\n")
      end

    end #END SELF

    private

    def self.filter(arr, allowed)
      arr.keep_if { |x| allowed.include? x }
    end

    def self.basic_format( text = nil, url = nil, tag = nil )
      text ||= sentence.chomp('.')
      url  ||= 'google.com'
      tag  ||= word.join(' ')
      "[" + text + "](http://" + url + ' "' + tag + '")'
    end

    def self.resolve_md(input, title=false)
      case input
        when Array then title ? input.map {|x| x.capitalize}.join(' ') : input.join(' ')
        else title ? input.split(' ').map {|x| x.capitalize}.join(' ') : input
      end
    end

  end
end
