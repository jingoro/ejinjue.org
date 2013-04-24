###
# Compass
###

# Susy grids in Compass
# First: gem install susy
# require 'susy'

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

activate :directory_indexes

page "/404.html", :directory_index => false

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
helpers do

  JOHN_LINKS = YAML.load_file(File.expand_path('../source/john/links.yaml', __FILE__))
  def john_link(name)
    i = JOHN_LINKS[name]
    img = image_tag "john-links/#{i['image']}", alt: i['name']
    link_to img, i['url'], :title => i['name']
  end

end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :cache_buster
  activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end

activate :deploy do |deploy|
  deploy.method = :rsync
  deploy.user = 'jingoro'
  deploy.host = 'imaginary.yerk.org'
  deploy.path = '/var/www/static/ejinjue/root'
end
