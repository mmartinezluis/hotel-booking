class HotelsController < ApplicationController

  def index
    if AmadeusApi.all.first
      api = AmadeusApi.all.first
    else
      api = AmadeusApi.new
    end
  end

end
