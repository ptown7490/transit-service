class HomeController < ApplicationController

  def index
    @documentation_url = "https://app.swaggerhub.com/apis/ptown1690/transit-service/1.0#/"
    @agencies = Agency.all
  end

end
