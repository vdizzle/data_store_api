######################################
# table_name:  raw_uploads
#--------------------------------------
# filename  :  string,        not null
# filetype  :  string,        not null
# content   :  text,          not null
# line_count:  integer,       not null
# size      :  integer,       not null
# table_name:  string
# meta_info :  text
######################################

class RawUpload < ActiveRecord::Base
  attr_accessible :filename, :filetype, :content, :size, :line_count
  attr_protected :table_name, :meta_info

  validates :filename, presence: true
  validates :filetype, presence: true
  validates :content, presence: true
  validates :line_count, presence: true, numericality: { only_integer: true }
  validates :size, presence: true, numericality: { only_integer: true }

  before_validation do
    self.filetype = (self.filetype || '').upcase
  end

  def sample(line_count = 20)
    data = []
    headers = split_to_row(content.lines.first, true)
    sample_line_count = [content.lines.count, line_count].min
    content.lines.each do |line|
      row = split_to_row(line)
      data << formatted_row(row, headers)
      break if data.count == sample_line_count
    end
    data.delete_at(0)
    data
  end

  def formatted_row(row, headers)
    data = {}
    headers.zip(row).each do |key, value|
      data[key] = value
    end
    data
  end

  def split_to_row(line, header = false)
    line.gsub("\r\n", '').
         gsub("\n", '').
         split(',').
         map do |w|
           w.strip!
           w = w.titleize if header
           w
         end
  end
end
