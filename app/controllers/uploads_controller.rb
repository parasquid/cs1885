require 'csv'
class UploadsController < ApplicationController
  def index
  end

  def sales_data
    if request.post? && params[:csv].present?
      Thread.new {
        infile = params[:csv].read.gsub(",=", ',')
        n, errs, headers = 0, [], []
        CSV.parse(infile) do |row|
          n += 1
          if n == 1
            headers = row.map {|i| i.to_s.downcase.parameterize.underscore.to_sym }
            next
          end
          # skip blank row
          next if row.join.blank?

          line = {}
          headers.each_with_index {|header, index| line[header] = row[index]}

          Sale.create! line
        end
      }
    end
    redirect_to uploads_path, notice: 'CSV uploaded successfully'
  end
end
