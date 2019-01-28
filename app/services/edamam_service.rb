class EdamamService
    def recipes(ingredient)
        # app_id = ENV['APPLICATION_ID']
        # app_key = ENV['APPLICATION_KEY']

        app_id = '4943cac2'
        app_key = 'b90dd8ef12bbae77e31045fb586d2b0c'

        resp = Faraday.get 'https://api.edamam.com/search' do |req|
            req.params['q'] = ingredient
            req.params['app_id'] = app_id
            req.params['app_key'] = app_key
            req.headers['Content-Type'] = 'application/json'
        end
        
        
        JSON.parse(resp.body)['hits']
    end
end