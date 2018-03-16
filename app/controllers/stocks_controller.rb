class StocksController < ApplicationController

  def search
    if params[:stock].blank?
      flash.now[:danger] = 'Stock symbol cant be blank'
    else
      @stock = Stock.new_from_lookup(params[:stock])
      flash.now[:danger] = 'Enter a proper stock symbol' unless @stock
    end
    respond_to do |format|
      format.js { render partial: 'users/result' }
    end
  end
end