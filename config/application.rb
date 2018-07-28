require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ImpalaApp
  class Application < Rails::Application
    # Add bower path to assets pipeline
    config.assets.paths << Rails.root.join("vendor","assets",'components',"bower_components","bootstrap-sass-official","assets","fonts")
    config.time_zone = 'Bogota'
    # set locales
    config.i18n.default_locale = :es
    config.i18n.available_locales = [:es]
    config.encoding = "utf-8"
    config.assets.precompile += [/^[a-z0-9]\w+\.(css|js)$/]
    config.assets.precompile.shift
    # Explicitly register the extensions we are interested in compiling
    config.assets.precompile.push(Proc.new do |path|
      File.extname(path).in? [
        '.html', '.erb', '.haml', 'slim',         # Templates
        '.png',  '.gif', '.jpg', '.jpeg', '.svg', # Images
        '.eot',  '.otf', '.svc', '.woff', '.ttf', # Fonts
      ]
    end)
    config.assets.precompile += %w[*.png *.jpg *.jpeg *.gif]
    config.to_prepare do
        ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
            html = %(<div class="form-group has-feedback has-error">#{html_tag}
                     </div>).html_safe
            if html_tag =~ /\<label/
                html_tag
            else
                errors = Array(instance.error_message).join(',')
                html << %(<small class="help-block errors_msj" >&nbsp;#{errors}</small>).html_safe
            end

        end
    end
    config.active_record.raise_in_transactional_callbacks = true
  end
end
