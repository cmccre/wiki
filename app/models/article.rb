class Article < ApplicationRecord
	validates :title, presence: true
	validates :content, presence: true
	belongs_to :user

	def self.searchCurrent(query)
	  if query
	    where('title LIKE ? AND is_current_article = ?', "%#{query}%", true).order('created_at DESC')
	  else
	    where('is_current_article = ?', true).order('created_at DESC') 
	  end
	end
end
