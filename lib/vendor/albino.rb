##
# Wrapper for the Pygments command line tool, pygmentize.
#
# Pygments: http://pygments.org/
#
# Assumes pygmentize is in the path.  If not, set its location
# with Albino.bin = '/path/to/pygmentize'
#
# Use like so:
#
#   @syntaxer = Albino.new('/some/file.rb', :ruby)
#   puts @syntaxer.colorize
#
# This'll print out an HTMLized, Ruby-highlighted version
# of '/some/file.rb'.
#
# To use another formatter, pass it as the third argument:
#
#   @syntaxer = Albino.new('/some/file.rb', :ruby, :bbcode)
#   puts @syntaxer.colorize
#
# You can also use the #colorize class method:
#
#   puts Albino.colorize('/some/file.rb', :ruby)
#
# Another also: you get a #to_s, for somewhat nicer use in Rails views.
#
#   ... helper file ...
#   def highlight(text)
#     Albino.new(text, :ruby)
#   end
#
#   ... view file ...
#   <%= highlight text %>
#
# The default lexer is 'text'.  You need to specify a lexer yourself;
# because we are using STDIN there is no auto-detect.
#
# To see all lexers and formatters available, run `pygmentize -L`.
#
# Chris Wanstrath // chris@ozmm.org 
#         GitHub // http://github.com
#
require 'open4'
require 'net/http'
require 'uri'
require 'tempfile'

class Albino
  @@bin = (defined?(Rails.env) && Rails.env.development?) ? 'pygmentize' : '/usr/bin/pygmentize'
  
  @@use_web_api = false
  
  WEB_API_ROOT = URI.parse('http://pygments.appspot.com/')

  def self.highlight_code(html)
    doc = Nokogiri::HTML(html)
    doc.search('div.code').each do |div|
      lexer = div['rel'] || :ruby
      lexted_text = Albino.new(div.text, lexer).to_s
      highlighted = Nokogiri::HTML(lexted_text).at('div')
      klasses = highlighted['class'].split(/\s+/)
      klasses << lexer
      klasses << 'code'
      klasses << 'highlight'
      highlighted['class'] = klasses.join(' ')
      div.replace highlighted
    end
    doc.search('body > *').to_html
  end

  def self.bin=(path)
    @@bin = path
  end
  
  def self.use_web_api?
    @@use_web_api
  end
  
  def self.use_web_api=(value)
    @@use_web_api = !!value
  end

  def self.colorize(*args)
    new(*args).colorize
  end

  def initialize(target, lexer = :text, format = :html)
    @target  = File.exists?(target) ? File.read(target) : target rescue target
    @options = { :l => lexer, :f => format }
    @web_options = {'lang' => lexer.to_s}
  end

  def execute(command)
    tmp = Tempfile.new("albino")
    tmp.write @target
    tmp.close
    command = [command, tmp.path].join(" ")
    %x(#{command}).strip
  ensure
    tmp.unlink if tmp
  end
  
  def highlight_via_api
    request = Net::HTTP.post_form(WEB_API_ROOT, @web_options.merge('code' => @target))
    request.body
  end

  def colorize(options = {})
    if self.class.use_web_api?
      highlight_via_api
    else
      execute @@bin + convert_options(options)
    end
  end
  alias_method :to_s, :colorize

  def convert_options(options = {})
    @options.merge(options).inject('') do |string, (flag, value)|
      string + " -#{flag} #{value}"
    end
  end
end
