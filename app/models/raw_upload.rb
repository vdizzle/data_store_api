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
    lines = []
    sample_line_count = [content.lines.count, line_count].min
    content.lines do |line|
      lines << line.
                 gsub("\r\n", '').
                 gsub("\n", '').
                 split(',').
                 map { |w| w.strip }
      break if lines.count == sample_line_count
    end
    lines
  end
end
