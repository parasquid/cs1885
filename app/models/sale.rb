class Sale < ActiveRecord::Base
  attr_accessible :date, :product, :store, :volume

  extend ModelCache

  def self.best_sellers
    select("date, product, sum(volume) as total_price").group("date", "product")
  end

end
