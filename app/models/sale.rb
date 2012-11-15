class Sale < ActiveRecord::Base
  attr_accessible :date, :product, :store, :volume

  extend ModelCache

  def self.best_products(limit=nil, date=nil)
    query = select("date, product, sum(volume) as total_price")
    .group("date", "product")
    .order("total_price desc")
    query = query.limit(limit) if limit
    query = query.where(date: date) if date
  end

  def self.best_products_by_date(limit = nil)
    b = {}
    all_dates.each do |sale|
      b[sale.date] = best_products(limit, sale.date)
    end
    b
  end

  def self.best_stores(limit=nil, date=nil)
    query = select("date, store, sum(volume) as total_price")
    .group("date", "store")
    .order("total_price desc")
    query = query.limit(limit) if limit
    query = query.where(date: date) if date
  end

  def self.best_stores_by_date(limit = nil)
    b = {}
    all_dates.each do |sale|
      b[sale.date] = best_stores(limit, sale.date)
    end
    b
  end

  def self.all_dates
    select("date").group("date").order("date desc")
  end

end
