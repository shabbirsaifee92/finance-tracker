class RenameFrienshipToFriendship < ActiveRecord::Migration[5.1]
  def change
    rename_table :frienships, :friendships
  end
end
