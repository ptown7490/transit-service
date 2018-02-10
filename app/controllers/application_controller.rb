class ApplicationController < ActionController::Base
  include Response
  include ExceptionHandling
  protect_from_forgery with: :exception
end
