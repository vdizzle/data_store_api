FactoryGirl.define do
  factory :raw_upload do
    sequence(:filename) { |n| "data-file-#{n}.csv" }
    filetype 'csv'
    content """Name,Email,Address
      Winston Churchill, wc@gmail.com, awesome
      Adolf Hitler, ah@gmail.com, hell"""
    size 953
    line_count 3
    table_name ''
    meta_info '{}'
  end
end
