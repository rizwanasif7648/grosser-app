Apipie.configure do |config|
  config.app_name                = "Myapp"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/apidoc"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.translate         = false
  config.default_locale = nil
end
