class Problem < ApplicationRecord
	has_many :solutions
	has_and_belongs_to_many :contests
	
	mount_uploader :descriptionFile, FileUploader
	mount_uploader :inputFile, InoutUploader
	mount_uploader :outputFile, InoutUploader
end
