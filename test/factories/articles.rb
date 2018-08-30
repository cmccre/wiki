FactoryBot.define do  
	factory :article do    
		user 
		sequence(:title) { |n| "Article #{n}" }
		content { Faker::Lorem.paragraphs(5) }
		is_current_article { false }

		trait :current_article do
			is_current_article { true }
		end

    	trait :astrology do
      		after(:create) { |article| article.update_attributes(tag_list: 'astrology') }
    	end

    	trait :biology do
      		after(:create) { |article| article.update_attributes(tag_list: 'biology') }
    	end

    	trait :chemistry do
      		after(:create) { |article| article.update_attributes(tag_list: 'chemistry') }
    	end

    	trait :demography do
      		after(:create) { |article| article.update_attributes(tag_list: 'demography') }
    	end

    	trait :ecology do
      		after(:create) { |article| article.update_attributes(tag_list: 'ecology') }
    	end


    	trait :feminism do
      		after(:create) { |article| article.update_attributes(tag_list: 'feminism') }
    	end


    	trait :geology do
      		after(:create) { |article| article.update_attributes(tag_list: 'geology') }
    	end


    	trait :history do
      		after(:create) { |article| article.update_attributes(tag_list: 'history') }
    	end

    	trait :immunology do
      		after(:create) { |article| article.update_attributes(tag_list: 'immunology') }
    	end

    	trait :jazz do
      		after(:create) { |article| article.update_attributes(tag_list: 'jazz') }
    	end

    	trait :kinaesthetics do
      		after(:create) { |article| article.update_attributes(tag_list: 'kinaesthetics') }
    	end

    	trait :law do
      		after(:create) { |article| article.update_attributes(tag_list: 'law') }
    	end

    	trait :math do
      		after(:create) { |article| article.update_attributes(tag_list: 'math') }
    	end

    	trait :neuroscience do
      		after(:create) { |article| article.update_attributes(tag_list: 'neuroscience') }
    	end

    	trait :oncology do
      		after(:create) { |article| article.update_attributes(tag_list: 'oncology') }
    	end

    	trait :physics do
      		after(:create) { |article| article.update_attributes(tag_list: 'physics') }
    	end

    	trait :quantum_mechanics do
      		after(:create) { |article| article.update_attributes(tag_list: 'quantum_mechanics') }
    	end

    	trait :radiology do
      		after(:create) { |article| article.update_attributes(tag_list: 'radiology') }
    	end

    	trait :sociology do
      		after(:create) { |article| article.update_attributes(tag_list: 'sociology') }
    	end

    	trait :theology do
      		after(:create) { |article| article.update_attributes(tag_list: 'theology') }
    	end

    	trait :user_experience do
      		after(:create) { |article| article.update_attributes(tag_list: 'user_experience') }
    	end

    	trait :virology do
      		after(:create) { |article| article.update_attributes(tag_list: 'virology') }
    	end

    	trait :world_studies do
      		after(:create) { |article| article.update_attributes(tag_list: 'world_studies') }
    	end

    	trait :x_ray_astronomy do
      		after(:create) { |article| article.update_attributes(tag_list: 'x_ray_astronomy') }
    	end

    	trait :youngs_experiment do
      		after(:create) { |article| article.update_attributes(tag_list: 'youngs_experiment') }
    	end

    	trait :zoology do
      		after(:create) { |article| article.update_attributes(tag_list: 'zoology') }
    	end 
	end  
end 