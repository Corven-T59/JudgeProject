class Problem < ApplicationRecord
	has_many :solutions
	has_and_belongs_to_many :contests
  acts_as_taggable
  include NotDeleteable

	validates_presence_of :name, :baseName, :timeLimit, :descriptionFile, :inputFile, :outputFile
	validates :timeLimit, numericality: {greater_than: 0}
  validate :valid_delimiter

	mount_uploader :descriptionFile, FileUploader
	mount_uploader :inputFile, InoutUploader
	mount_uploader :outputFile, InoutUploader

  def self.search search
    if search
      tags = Problem.includes(:tags).tagged_with(search)
      by_name = Problem.includes(:tags).where('name LIKE ?', "%#{search}%")
      tags + by_name
    end
  end

  private

  def valid_delimiter
    if delimiter.try(:include?, "'")
      errors.add(:delimiter, "El delimitador no puede incluir el caracter '")
    elsif delimiter.try(:include?, '"')
      errors.add(:delimiter, 'El delimitador no puede incluir el caracter "')
    end
  end

end
