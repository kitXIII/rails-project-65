class AddStateToBulletins < ActiveRecord::Migration[7.1]
  def change
    add_column :bulletins, :state, :string

    Bulletin.update_all(state: :draft)
  end
end
