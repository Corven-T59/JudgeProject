class Problem < ApplicationRecord
	has_many :solutions

	mount_uploader :descriptionFile, FileUploader
	mount_uploader :inputFile, InoutUploader
	mount_uploader :outputFile, InoutUploader
end