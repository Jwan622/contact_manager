class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.string :number
      t.integer :person_id

      t.timestamps null: false   #if you try to insert into a database, it will kick it back. It's a database-side validation. I can't insert into it without timestamps. 
    end
  end
end
