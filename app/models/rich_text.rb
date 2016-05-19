class RichText
  HTML_OPTIONS = { filter_html: true, safe_links_only: true, no_images: true }.freeze
  MD_OPTIONS = { autolink: true }.freeze

  attr_reader :source
  alias to_s source

  def initialize(source, rendered = nil)
    @source = source
    @rendered = rendered
  end

  def mongoize
    { source: source, rendered: rendered }
  end

  def rendered
    @rendered ||= render(source)
  end

  def blank?
    @source.blank?
  end

  private

  def render(source)
    unless source.nil?
      html_renderer = Redcarpet::Render::HTML.new(HTML_OPTIONS)
      renderer = Redcarpet::Markdown.new(html_renderer, MD_OPTIONS)
      return renderer.render(source)
    end
  end

  class << self
    def demongoize(object)
      object = {} if object.nil?
      RichText.new(object[:source], object[:rendered])
    end

    def mongoize(object)
      case object
      when RichText then object.mongoize
      when Hash then RichText.new(object[:source], object[:rendered]).mongoize
      when String then RichText.new(object).mongoize
      else object
      end
    end

    def evolve(object)
      case object
      when RichText then object.mongoize
      else object
      end
    end
  end
end
