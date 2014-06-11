require 'pygments'

module ApplicationHelper

  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code code, language
      Pygments.highlight(code, lexer: language)
    end
  end

  @@markdown = Redcarpet::Markdown.new(HTMLwithPygments.new(escape_html: true), fenced_code_blocks: true)

  def markdown_to_html str
    @@markdown.render str
  end

  def qygments_css
    content_tag :style, Pygments.css('.highlight')
  end

  def qiniu_token_tag
    put_policy = Qiniu::Auth::PutPolicy.new('scauhci')
    token = Qiniu::Auth.generate_uptoken(put_policy)
    tag :meta, content: token, name: 'qiniu-token'
  end
  
end
