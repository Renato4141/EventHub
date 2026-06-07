class RenameUserRoles < ActiveRecord::Migration[8.1]
  def change
    # attendee (0) -> regular (0), organizer (1) -> regular (0), admin (2) stays
    execute "UPDATE users SET role = 0 WHERE role = 1"
  end
end