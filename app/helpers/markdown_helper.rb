module MarkdownHelper

  def markdown(text)
    markdown_engine.render(text).html_safe
  end

  private

  def markdown_engine
    @redcarpet_mardown ||= begin
      renderer = Redcarpet::Render::HTML.new hard_wrap: true, filter_html: true
      Redcarpet::Markdown.new renderer, redcarpet_options
    end
  end

  def redcarpet_options
    {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
  end
end
