class UserPresenter < BasePresenter
  presents :user

  delegate :email, :created_at, :updated_at, to: :user

  # Other presenter methods to help show user information
end
