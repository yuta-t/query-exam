csv_dir = "#{Rails.root}/db/csv/"
csv_files = ['users.csv', 'shifts.csv']

csv_files.each do |csv_file|
  puts csv_file
  csv = TableCsv.new(csv_dir, csv_file)
  puts "Impoting #{csv_file}"
  csv.truncate_table
  csv.load_escape_csv
  csv.create_model
end
