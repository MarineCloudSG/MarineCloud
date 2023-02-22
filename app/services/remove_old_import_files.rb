class RemoveOldImportFiles < Patterns::Service
  def call
    MeasurementsImport.where("created_at < ?", 3.month.ago).each do |import|
      import.file.purge
    end
  end
end
