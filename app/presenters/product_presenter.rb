class ProductPresenter < BasePresenter
  presents :product

  delegate :name, :description, :cost, :created_at, :updated_at, to: :product

  # Other presenter methods to help show user information
end
