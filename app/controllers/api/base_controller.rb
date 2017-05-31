class Api::BaseController < ApplicationController

# to identify HTML forms that are created by your rails app,
# rails adds a hidden field that contains a CRSF token (cross site requrest forgery)
#For a JSON API, we want to skip this security check and use our own. This is
# necessary otherwise Rails will disallow all POST requests made without a
# CRSF token signed with Rails Secret from 'config/secret.yml'
skip_before_filter :verify_authenticity_token

before_action :authenticate_user

  private

  def authenticate_user
    @user = User.find_by_api_token params[:api_token]
    # head will send an empty HTTP response with a code that is inferred by the
    # symbol you pass as an argument to the `head` method
    head :unauthorized if @user.nil?
  end
end
