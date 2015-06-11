class CreateRawUploads < ActiveRecord::Migration
  def change
    create_table(:raw_uploads) do |t|
      t.string       :filename,     null: false
      t.string       :filetype,     null: false
      t.text         :content,      null: false
      t.integer      :line_count,   null: false,   default: 0
      t.integer      :size,         null: false,   default: 0
      t.string       :table_name,                  default: ''
      t.text         :meta_info,                   default: ''
      t.timestamps
    end
  end
end
