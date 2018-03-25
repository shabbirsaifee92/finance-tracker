class User < ApplicationRecord
  STOCKLIMIT = 10
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  def has_stock?(ticker_symbol)
    stocks.any? do |stock|
      stock.ticker == ticker_symbol
    end
  end

  def reached_stock_limit?
    user_stocks.count == STOCKLIMIT
  end

  def can_add_stock?(ticker_symbol)
    return true unless has_stock?(ticker_symbol) || reached_stock_limit?
  end

  def full_name
    return "#{first_name} #{last_name}".strip if first_name || last_name
    'Anonymous'
  end

  def self.search(param)
    param.strip!
    param.downcase!
    to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
    return nil unless to_send_back
    to_send_back
  end

  def self.first_name_matches(param)
    matches('first_name', param)
  end

  def self.last_name_matches(param)
    matches('last_name', param)
  end

  def self.email_matches(param)
    matches('email', param)
  end

  def self.matches(field_name, param)
    User.where("#{field_name} like?", "%#{param}%")
  end


end

