class CreateRawUploads < ActiveRecord::Migration
  def change
    create_table(:raw_uploads) do |t|
      t.string       :filename,     null: false
      t.text         :content,      null: false
      t.integer      :size,                        default: 0
      t.string       :table_name,                  default: ''
      t.string       :meta_info,                   default: ''
      t.timestamps
    end
  end
end
