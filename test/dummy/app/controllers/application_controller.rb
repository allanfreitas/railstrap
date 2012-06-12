class ApplicationController < ActionController::Base
  protect_from_forgery

  layout 'painel'

  #before_filter :tb_namespace
end
