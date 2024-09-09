class ApplicationController < ActionController::Base
  before_action :set_locale
  def set_locale #Função de de identificação de  Idioma
    if params[:locale] # gera apos o click
      cookies[:locale] = params[:locale]
    end
    if cookies[:locale]
      if I18n.locale != cookies[:locale] # (locale)Helper que armazena o Idioma atual(locale.rb)
        I18n.locale = cookies[:locale]
      end
    end
    end
end
