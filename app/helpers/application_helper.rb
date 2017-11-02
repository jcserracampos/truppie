module ApplicationHelper
  include ActionView::Helpers::NumberHelper

  def flash_status(status)
    case status
    when 'error'
      {:className => 'danger', :label => t('ops') }
    when 'notice'
      {:className => 'info', :label => t('hey')}
    when 'success'
      {:className => 'success', :label => t('oba')}
    else
      {:className => 'info', :label => t('aviso') }
    end
  end

  def friendly_when(t)
    if t > Time.now
      "daqui a #{time_ago_in_words(t)}"
    else
      "#{time_ago_in_words(t)} atrás"
    end
  end

  def form_error(errors, error_field)
    if !errors.nil? and errors.key?(error_field.to_s)
      'has-danger'
    else
      ''
    end
  end

  def form_field_error(errors, error_field)
    if !errors.nil? and errors.key?(error_field.to_s)
      'form-control-danger'
    else
      ''
    end
  end

  def error_message(errors, error_field)
    if !errors.nil? && errors.key?(error_field.to_s)
      raw "<small class=\"text-help\">#{errors[error_field.to_s][0]}</small>"
    else
      ''
    end
  end

  def error_message_text(errors, error_field)
    if !errors.nil? && errors.key?(error_field.to_s)
      raw "#{errors[error_field.to_s][0]}"
    else
      ''
    end
  end

  def to_https(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    return http.get(uri.request_uri)
  end

  def friendly_price(p)
    if p > 0
      number_to_currency(p.to_f/100, :unit => "R$")
    else
      number_to_currency(0, :unit => "R$", precision: 0)
    end
  end

  def final_price(p)
    if p
      return "<small>R$</small><span>#{p}</span>"
    else
      "<small> não conseguimos obter o preço </span>"
    end
  end

  def final_price_from_cents(p)
    if p.to_i
      return "<small>R$</small><span>#{p/100}</span>"
    else
      "<small> não conseguimos obter o preço </span>"
    end
  end

  def raw_price(p)
    n = number_with_precision(p, precision: 2, separator: ',').to_s.gsub(',', '.').to_f*100
    n.to_i
  end

  def transfer_status(s)
    status = {
      "REQUESTED" => "Solicitado",
      "COMPLETED" => "Completado",
      "FAILED" => "Falhou"
    }
    status[s]
  end

  def bank_list
    banks = YAML.load_file('config/banks.yml')

    if Rails.env == "production"
      banks["banks"].shift
    end
    banks
  end

  def to_https(url)
    uri = URI.parse(url)
    uri.scheme = "https"
    return uri.to_s
  end

  def is_active(page)
    return current_page? action: page
  end
end
