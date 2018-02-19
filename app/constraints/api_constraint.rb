# Code borrowed from github.com/iamvery/rails-api-example
class ApiConstraint
  attr_reader :version

  def initialize(options)
    @version = options.fetch(:version)
  end

  def matches?(request)
    request
      .headers
      .fetch(:accept)
      .include?("version=#{version}")
  end
end
