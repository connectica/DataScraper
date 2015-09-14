class FirmsController < ApplicationController


  def json1
  	#This get the first JSON result from th YP dataset
  	@result = params[:id]
  end

  def json2
  	@item = "rettwe"
  end

  def scan

  end

end
