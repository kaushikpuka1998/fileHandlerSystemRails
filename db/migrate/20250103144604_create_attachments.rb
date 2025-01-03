class CreateAttachments < ActiveRecord::Migration[7.0]
  def change
    create_table :attachments do |t|
      t.references :user, null: false, foreign_key: true
      t.string :file
      t.string :title
      t.string :url
      t.string :type
      t.text :description

      t.timestamps
    end
  end
end
