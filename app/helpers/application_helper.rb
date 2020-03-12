module ApplicationHelper
  NAVBAR_ITEMS = {
    'users' => Rails.application.routes.url_helpers.users_path,
    'tests' => Rails.application.routes.url_helpers.tests_path,
  }.freeze

  def flash_class(level)
    case level.to_sym
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-danger"
      when :alert then "alert alert-danger"
    end
  end

  def current_controller?(controller_name)
    params[:controller] == controller_name
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def render_button(text, icon_name, link, options = {})
    link_to(link, class: "btn btn-primary mb-3 #{options[:class]}") do
      content_tag(:i, nil, class: "fa fa-#{icon_name} ") +
        content_tag(:span, text, class: 'ml-2')
    end
  end
end
