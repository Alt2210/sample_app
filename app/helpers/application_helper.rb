module ApplicationHelper
  def full_title page_title = ""
    base_title = t("helpers.application.base_title")
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def language_switch_params locale:
    safe_params = request.path_parameters.merge(request.query_parameters)

    if request.request_method_symbol != :get
      safe_params = extract_referer_params(safe_params)
    end

    safe_params[:locale] = locale

    begin
      url_for(safe_params)
    rescue ActionController::UrlGenerationError
      root_url(locale:)
    end
  end

  private

  def extract_referer_params current_params
    return current_params unless request.referer

    referer_uri = URI(request.referer)
    referer_params = Rails.application.routes.recognize_path(referer_uri.path)

    if referer_uri.query.present?
      query_params =
        Rack::Utils.parse_nested_query(referer_uri.query).symbolize_keys
      referer_params.merge!(query_params)
    end

    referer_params
  rescue ActionController::RoutingError, StandardError
    current_params
  end
end
