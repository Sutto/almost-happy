require 'nokogiri'
require 'RedCloth'
require 'rdiscount'

require File.expand_path('../vendor/albino', File.dirname(__FILE__))

module AlmostHappy
  class Convertor
    
    def self.use_web_api!
      Albino.use_web_api = true
    end
    
    class Renderer < Struct.new(:name, :options, :renderer)

      def [](key)
        options[key.to_sym]
      end

      def render(content)
        renderer.call(content.to_s).to_s.html_safe
      end

      def human_name
        ::I18n.t(name, :scope => :"almost_happy.renderers.human_names", :default => name.to_s.humanize)
      end

    end

    class_attribute :renderers, :renderer_options
    self.renderers = {}

    def self.add_renderer(key, *args, &blk)
      options = args.extract_options!
      renderer = (args.pop || blk).to_proc
      self.renderers[key.to_s] = Renderer.new(key, options, renderer)
    end

    def self.render_for(key, content)
      renderer = self.renderers[key.to_s]
      content  = content.to_s
      renderer.present? ? renderer.render(content) : content
    end

    def self.for_select
      self.renderers.values.map do |r|
        [r.human_name, r.name.to_s]
      end.sort
    end
    
    def self.format_names
      self.renderers.values.map { |r| r.human_name }.to_sentence :two_words_connector => " or ", :last_word_connector => ", or "
    end

    def self.[](key)
      renderers[key.to_s].try(:options) || {}
    end

    def self.valid_format?(name)
      renderers.keys.include? name.to_s
    end

    attr_reader :object, :source_field

    def initialize(object, source_field)
      @object       = object
      @source_field = source_field
    end

    def original_content
      @object.send source_field
    end

    def rendered_content=(value)
      @object.send :"rendered_#{source_field}=", value
    end

    def to_html
      conversion_from = @object.send(:format_for, @source_field) rescue nil
      self.class.render_for(conversion_from, original_content)
    end

    def render
      self.rendered_content = self.to_html
    end

    add_renderer :textile do |raw|
      Albino.highlight_code RedCloth.new(raw).to_html
    end

    add_renderer :markdown, :filters => [:smart, :autolink] do |raw|
      html = RDiscount.new(raw, *Convertor[:markdown].fetch(:filters, [])).to_html
      html.gsub!(/^(?:<p>)?@@@(?:<\/p>)?$/, '</div>')
      html.gsub!(/^(?:<p>)?@@@\s*([\w\+]+)(?:<\/p>)?$/, '<div class="code" rel="\1">')
      Albino.highlight_code(html)
    end

    add_renderer :raw do |raw|
      Albino.highlight_code(raw.to_s)
    end

  end
end
