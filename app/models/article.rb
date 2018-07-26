class Article < ApplicationRecord
	validates :title, presence: true
	validates :content, presence: true
	belongs_to :user

	def self.search(query)
	  if query
	    where('title LIKE ?', "%#{query}%").order('created_at DESC')
	  else
	    order('created_at DESC') 
	  end
	end
end
