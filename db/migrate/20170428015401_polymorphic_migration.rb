class PolymorphicMigration < ActiveRecord::Migration[5.0]
  def change
    remove_column :stocks, :stockholder_id
    remove_column :stocks, :stockholder_type
    add_reference :stocks, :stockholder, polymorphic: true, index: true
  end
end
