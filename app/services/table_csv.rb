require "csv"

class TableCsv
  def initialize(dir_name,file_name)
    @dir_name = dir_name
    @file_name = file_name
    @table_name = File.basename(@file_name, '.csv')
    @model = @table_name.classify.constantize
  end

  def file_path
    "#{@dir_name}#{@file_name}"
  end

  def truncate_table
    ActiveRecord::Base.connection.execute("TRUNCATE #{@table_name}")
  end

  def load_csv
    @text = File.read(file_path)
  end

  def load_escape_csv
    @text = File.read(file_path).gsub(/(?<!\\)\\"/,'""')
  end

  def create_model
    CSV.parse(@text, headers: true, header_converters: :symbol) do |row|
      @model.create(row.to_hash)
    end
  end

  def export_table
    CSV.generate do |csv|
      csv << @model.column_names
      @model.all.each do |model|
        csv << model.attributes.values_at(*@model.column_names)
      end
    end
  end

  class << self
    def import_table_csvs
      csv_dir = "#{Rails.root}/db/csv/"
      csv_files = Dir.entries(csv_dir).select {|f| f =~ /\.csv$/ }
      csv_files.each do |csv_file|
        puts csv_file
        csv = TableCsv.new(csv_dir, csv_file)
        puts "Impoting #{csv_file}"
        csv.truncate_table
        csv.load_escape_csv
        csv.create_model
      end
    end

    def export_table_csvs
      csv_dir = "#{Rails.root}/db/csv/"
      csv_files = Dir.entries(csv_dir).select {|f| f =~ /\.csv$/ }
      csv_files.each do |csv_file|
        csv = TableCsv.new(csv_dir, csv_file)
        csv_string = csv.export_table
        File.open(csv.file_path, 'w') do |file|
          file.write(csv_string)
        end
      end
    end
  end
end