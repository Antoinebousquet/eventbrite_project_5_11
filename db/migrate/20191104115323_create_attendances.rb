class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.string :stripe_customer_id

      t.belongs_to :guest, index: true

      t.belongs_to :attended_event, index: true

      t.timestamps
    end
  end
end
