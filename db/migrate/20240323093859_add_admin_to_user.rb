class AddAdminToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :admin, :boolean, default: false, null: false

    email = AdminHelper.supervisor&.email

    User.where.not(email:).update_all(admin: false)
    User.where(email:).update_all(admin: true)
  end
end
