# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

# Don't reload this file for nanoc autocompile. Otherwise, nanoc will eventually
# throw an "ERROR SystemStackError: stack level too deep" exception.
unless defined? LOADED_DEFAULT_CONFIG

  LOADED_DEFAULT_CONFIG = true
  
  require 'compass'
  Compass.add_project_configuration File.expand_path('../../compass-config.rb', __FILE__)

  # include common helpers
  include Nanoc::Helpers::HTMLEscape
  include Nanoc::Helpers::LinkTo
  include Nanoc::Helpers::Rendering

  # cache busting
  require 'nanoc/cachebuster'
  include Nanoc::Helpers::CacheBusting
  
  # image compression
  require 'nanoc/filters/image_compressor'
  
  # javascript concatenation
  require 'nanoc/filters/javascript_concatenator'
  
  # custom to ejinjue.org
  
  require 'active_support/inflector'
  include Nanoc3::Helpers::Capturing
  
  JOHN_LINKS = YAML.load_file(File.expand_path('../../content/john/links.yaml', __FILE__))

  def page_class
    page = (@item[:page_name] || @item.identifier).parameterize
    page = 'home' if page == ''
    'page-' + page
  end

  def image_tag(url, alt='')
    "<img src='#{html_escape(url)}' alt='#{html_escape(alt)}'>"
  end

  def john_link(name)
    i = JOHN_LINKS[name]
    img = image_tag("/img/john-links/" + i['image'], i['name'])
    link_to img, i['url'], :title => i['name']
  end

end
