class FixSchema < ActiveRecord::Migration[8.1]
  def change
    rename_column :events, :title, :name
    change_column :registrations, :status, :integer, using: "status::integer", default: 0, null: false
  end
end