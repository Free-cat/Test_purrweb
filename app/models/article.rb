class Article < ApplicationRecord
  has_many :tags
  belongs_to :author
  belongs_to :category


  accepts_nested_attributes_for :tags

  scope :by_author, -> (author_id) { where(author_id: author_id) }
  scope :by_category, -> (category_id) { where(category_id: category_id) }
  scope :by_tag, -> (tag_name) { joins(:tags).where(tags: { name: tag_name }) }
  scope :today, -> { where(:created_at => (DateTime.now.at_beginning_of_day.utc..Time.now.utc)) }
end
