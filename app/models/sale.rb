class Sale
  include Mongoid::Document
  field :store, type: String
  field :product, type: String
  field :date, type: String
  field :volume, type: String
end
