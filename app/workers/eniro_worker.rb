class EniroWorker
  include Sidekiq::Worker
  def perform(id,count)


		puts "Henter enirodata for #{id}"

 

	found = false

  	eniro_id = ""

  	url = "https://api.eniro.com/mobile-backend?adjPx=0%2C0%2C0%2C0&viewPx=1024%2C1024&index=&zoom=3&pageSize=40&autoExpand=true&version=3&country=no&center=100.865080%2C62.559741&q=#{id}&relevance=GROUP_MOBILE&rsid=enirogulesiderappprod&offset=0&vid=2AF4ACDA852A309E-40000106600CDD09&phase=first&key=2599616109075854112&profile=iOSCore&disableRankLogic=true"
	response = HTTParty.get(url)
	json = JSON.parse(response.body)


	begin
		# can we find anything?
		features = json['search']['yp']['features']
	rescue
		puts "Fant ikke enirodata for #{id}"
		new_data = "[  {    ""error"": 404,    ""error_description"": ""NOT FOUND""  }]"
	else
		# The first listign we find relevanceLevel = "ORGANIZATION_NUMBER" we get our internal id and go hunting for the next API result
		features.each do |feature|
			unless found == true 
				if feature['relevanceLevel'] = "ORGANIZATION_NUMBER" 
					eniro_id = feature['id']
					found = true
				end
			end
		end

		#  	http://pano.maptilez.com/panorender/render?lon=10.8227442&lat=59.9194368&w=270&h=80",
		#		ok, next please  ECO84171003
		# => 84524644

		if found 
	  		url = "https://api.eniro.com/mobile-backend/ip?version=3&key=2599616109075854112&profile=iOSCore&country=no&eniro_id=#{eniro_id}&reviews_from=1&reviews_to=8&rsid=enirogulesiderappprod&vid=2AF4ACDA852A309E-40000106600CDD09"
			response = HTTParty.get(url)
			json = JSON.parse(response.body)
			#store data

			begin
				firmnavn =  json['advert']['companyInfo']['companyName']
				puts "lagrer enirodata for #{id} - #{firmnavn}" 
			rescue
			  	puts "Fant ikke companyName enirodata for #{id}"
				new_data = "[  {    ""error"": 500,    ""error_description"": ""COMPANY NAME NOT FOUND""  }]"
			else
			  puts "Congratulations-- no errors!"
			  new_data = response.body
			end

		else
			puts "Fant ikke enirodata for #{id}"
			new_data = "[  {    ""error"": 404,    ""error_description"": ""NOT FOUND""  }]"
		end

	end


	begin
		firma = Firm.where(orgnr: id).take!
		firma.enirodata = new_data
		firma.save
	rescue
		#json = JSON.parse(new_data)
		puts "could not save! error=#{new_data} "   #{json['error_description']}" 
	else
		puts "Saved data!"
	end



  end
end