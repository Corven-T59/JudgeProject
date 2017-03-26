class Problem < ApplicationRecord
	has_many :solutions
	has_and_belongs_to_many :contests

	validates_presence_of :name, :baseName, :timeLimit, :descriptionFile, :inputFile, :outputFile
	validates :timeLimit, numericality: {greater_than: 0}

	mount_uploader :descriptionFile, FileUploader
	mount_uploader :inputFile, InoutUploader
	mount_uploader :outputFile, InoutUploader
end
