class RenameTypeColumnInAttachments < ActiveRecord::Migration[7.0]
  def change
    rename_column :attachments, :type, :file_type
  end
end
