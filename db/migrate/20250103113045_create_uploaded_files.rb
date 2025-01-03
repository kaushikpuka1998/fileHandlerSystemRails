class CreateUploadedFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :uploaded_files do |t|
      t.string :title
      t.text :description
      t.string :file_url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
