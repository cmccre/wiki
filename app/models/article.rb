class Article < ApplicationRecord

	validates :title, presence: true
	validates :content, presence: true
	belongs_to :user
	acts_as_taggable

end
