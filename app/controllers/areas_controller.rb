class AreasController < ApplicationController
  def index
    @areas = Area.all.order('state ASC, name ASC')
  end
end