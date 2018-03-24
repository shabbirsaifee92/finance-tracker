class User < ApplicationRecord
  STOCKLIMIT = 10
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  def has_stock?(ticker_symbol)
    stocks.any? do |stock|
      stock.ticker == ticker_symbol
    end
  end

  def reached_stock_limit?
    user_stocks.count == STOCKLIMIT
  end

  def can_add_stock?(ticker_symbol)
    return true unless (has_stock?(ticker_symbol) || reached_stock_limit?)
  end

end

