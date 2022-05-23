class RenameCustomerIdColumnToOrderDetails < ActiveRecord::Migration[6.1]
  def change
    rename_column :order_details, :customer_id, :item_id
  end
end
