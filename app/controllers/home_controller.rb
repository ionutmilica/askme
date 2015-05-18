class HomeController < ApplicationController
  def index
    render html: '<h1>ASK API</h1>'.html_safe
  end
end