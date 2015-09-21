class Opplysningen1881Worker
  include Sidekiq::Worker
  def perform(id,count)

		puts "Henter data for #{id}"

  		#Find 1881 internal id
	  	url = "http://1881dm.giantleap.no/dmserver/api/v1/search/freetext?q=#{id}&lat=13.731043&lon=100.560560&client-id=64E05B54-749B-452A-8292-74BC92E16EC9"
	  	response = HTTParty.get(url)
		json = JSON.parse(response.body)
		unless json['suggestedType'] == "UNKNOWN"
			external_id = json['companyHits'][0]['hits'][0]['resultId']

			#Get company financial details 
#			url = "http://1881dm.giantleap.no/dmserver/api/v1/search/details/#{external_id}?client-id=64E05B54-749B-452A-8292-74BC92E16EC9"
#		  	response = HTTParty.get(url)
#			json = JSON.parse(response.body)

			#store data
			firmnavn =  json['juridical']['properties'][0]['value']
			puts "lagrer data for #{id} - #{firmnavn}" 
			new_data = json
		else
			puts "Fant ikke data for #{id}"
			new_data = "NOT FOUND"
		end
		firma = Firm.where(orgnr: id).take!
		firma.opplysningen = new_data
		firma.save

  end
end