class NotePresenter < BasePresenter
  presents :note

  delegate :value, :user, :created_at, :updated_at, to: :note

  def creator
    unless note.user.nil?
      note.user.email
    end
  end
  # Other presenter methods to help show user information
end
