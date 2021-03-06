Apipie.configure do |config|
  config.app_name                = "AssessmentSystemIwa"
  config.api_base_url            = "/api/v1"
  config.doc_base_url            = "/api/v1/apipie"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/v1/*.rb"
  config.translate               = false
  config.default_version         = '1.0'
  config.app_info["1.0"]         = <<~DOC
    = Introduction

    Assessment System API - IWA Test

    Currently, JSON is the only encoding format supported.
  DOC
end
