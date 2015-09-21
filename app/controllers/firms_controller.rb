class FirmsController < ApplicationController


  def json1
  	#This get the first JSON result from th YP dataset

  	orgnr = ""
  	eniro_id = ""
  	url = ""
		result = ""
		found = false

  	orgnr = params[:id]
  	url = "https://api.eniro.com/mobile-backend?adjPx=0%2C0%2C0%2C0&viewPx=1024%2C1024&index=&zoom=3&pageSize=40&autoExpand=true&version=3&country=no&center=100.865080%2C62.559741&q=#{orgnr}&relevance=GROUP_MOBILE&rsid=enirogulesiderappprod&offset=0&vid=2AF4ACDA852A309E-40000106600CDD09&phase=first&key=2599616109075854112&profile=iOSCore&disableRankLogic=true"
		response = HTTParty.get(url)
		json = JSON.parse(response.body)

		features = json['search']['yp']['features']

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
		#		ok, next please

  	url = "https://api.eniro.com/mobile-backend/ip?version=3&key=2599616109075854112&profile=iOSCore&country=no&eniro_id=#{eniro_id}&reviews_from=1&reviews_to=8&rsid=enirogulesiderappprod&vid=2AF4ACDA852A309E-40000106600CDD09"
		response = HTTParty.get(url)
		json = JSON.parse(response.body)

		@result = url

		firm =  Firm.new
		firm.enirodata = response.body
		firm.orgnr = orgnr
		firm.save


		#orgnr = json['search']['yp']['features'][0]['relevanceLevel']



# https://api.eniro.com/mobile-backend/suggest?profile=mobile&key=12345&country=no&q=Apotek
# 


# SØK PÅ ORGNR
# https://api.eniro.com/mobile-backend?adjPx=0%2C0%2C0%2C0&viewPx=1024%2C1024&index=&zoom=3&pageSize=40&autoExpand=true&version=3&country=no&center=100.865080%2C62.559741&q=976023188&relevance=GROUP_MOBILE&rsid=enirogulesiderappprod&offset=0&vid=2AF4ACDA852A309E-40000106600CDD09&phase=first&key=2599616109075854112&profile=iOSCore&disableRankLogic=true


#detaljer

#https://api.eniro.com/mobile-backend/ip?version=3&key=2599616109075854112&profile=iOSCore&country=no&eniro_id=88414585&reviews_from=1&reviews_to=8&rsid=enirogulesiderappprod&vid=2AF4ACDA852A309E-40000106600CDD09


#søk på nøkkelord

#https://api.eniro.com/mobile-backend?adjPx=0%2C0%2C0%2C0&viewPx=1024%2C1024&index=&zoom=3&pageSize=40&autoExpand=true&version=3&country=no&center=11.419677%2C62.559741&q=Apotek&relevance=GROUP_MOBILE&rsid=enirogulesiderappprod&offset=0&vid=2AF4ACDA852A309E-40000106600CDD09&phase=first&key=2599616109075854112&profile=iOSCore&disableRankLogic=true


#response['results'][0]['trackName']
#=> "Let It Happen"


  end

  def json2

  	#http://1881dm.giantleap.no/dmserver/api/v1/search/freetext?q=6536547&lat=13.731043&lon=100.560560&client-id=64E05B54-749B-452A-8292-74BC92E16EC9
  	#http://1881dm.giantleap.no/dmserver/api/v1/search/details/100954965S1?client-id=64E05B54-749B-452A-8292-74BC92E16EC9



  end

  def scan

  		#http://1881dm.giantleap.no/dmserver/api/v1/search/freetext?q=6536547&lat=13.731043&lon=100.560560&client-id=64E05B54-749B-452A-8292-74BC92E16EC9
			#http://1881dm.giantleap.no/dmserver/api/v1/search/details/100954965S1?client-id=64E05B54-749B-452A-8292-74BC92E16EC9

			#Find next company to rip
			firma = Firm.where(opplysningen: nil).limit(10).pluck(:orgnr)
		 	firma.each do |f|
				Opplysningen1881Worker.perform_async(f,0)
			end
	end


	def eniroscan
		$i = 1000
		firma = Firm.where(enirodata: nil).limit($i).pluck(:orgnr)
		firma.each do |f|
			EniroWorker.perform_async(f,0)
		end
		@result = "Kicked inn #{$i.to_s} firmids for sidekiq to rip!"
	end	


end

