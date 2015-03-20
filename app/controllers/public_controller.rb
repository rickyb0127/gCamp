class PublicController < ApplicationController
  skip_before_action :authorize
end
