# Generated via
#  `rails generate hyrax:work Folio`
class Folio < ActiveFedora::Base
  include ::Hyrax::WorkBehavior

  self.indexer = FolioIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }
  # TODO : what other types of validation can I add?

  # 13-12-2018 JL:
  include TcdExtendedMetadata

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata
end
