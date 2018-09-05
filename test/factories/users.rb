FactoryBot.define do  
	factory :user do    
		username { Faker::Internet.user_name(5) }  
		password { Faker::Internet.password(6) }
		is_admin { false }
		is_active { true }

		trait :admin do
	    	is_admin { true }
	  	end

	  	trait :banned do
	    	is_active { false }
	  	end  
	end  
end 