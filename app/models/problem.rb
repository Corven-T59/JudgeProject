class Problem < ApplicationRecord
	has_many :solutions
	has_and_belongs_to_many :contests
  acts_as_taggable
  include NotDeleteable

  # Validations for normal problems
  validates_presence_of :baseName, :timeLimit, :descriptionFile, :inputFile, :outputFile, :color, unless: :is_codeforces?
  validates :timeLimit, numericality: {greater_than: 0}, unless: :is_codeforces?
  validate :valid_delimiter

  # Validations for codeforces problems
  validates_presence_of :codeforces_contest_id, :codeforces_index, if: :is_codeforces?
  validates :codeforces_contest_id, numericality: {greater_than: 0}, if: :codeforces_contest_id

  # Validations for all
  validates_presence_of :name
  validate :valid_color

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

  def is_codeforces?
    (!codeforces_contest_id.nil? && !codeforces_index.try(:empty?))
  end

  private

  def valid_delimiter
    if delimiter.try(:include?, "'")
      errors.add(:delimiter, "El delimitador no puede incluir el caracter '")
    elsif delimiter.try(:include?, '"')
      errors.add(:delimiter, 'El delimitador no puede incluir el caracter "')
    end
  end

  def valid_color
    unless color.nil?
      errors.add(:color, "No es un color valido, debe contener exactamente 3 o 6 caracteres") unless (color.size == 3 || color.size == 6)
    end
  end

end
