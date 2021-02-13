require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Trading2
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.time_zone = 'Tokyo' #Time.zone.nowに日本時間を使用する
    config.active_record.default_timezone = :local #DBの読み書きに日本時間を使用する

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # デフォルトの言語を日本語に設定
    config.i18n.default_locale = :ja
    # config/locales以下のディレクトリ内にある全てのymlファイルを読み込むように指示
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml').to_s]
  end
end
