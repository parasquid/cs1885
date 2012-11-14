Parasquid1885::Application.routes.draw do
  match 'uploads' => 'uploads#index'
  post "uploads/sales_data"

  root to: 'home#index'
end
