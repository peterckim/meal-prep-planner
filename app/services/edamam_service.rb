class EdamamService
    def recipes(ingredient)
        app_id = ENV['APPLICATION_ID']
        app_key = ENV['APPLICATION_KEY']

        resp = Faraday.get 'https://api.edamam.com/search' do |req|
            req.params['q'] = ingredient
            req.params['app_id'] = app_id
            req.params['app_key'] = app_key
            req.headers['Content-Type'] = 'application/json'
        end
        
        
        JSON.parse(resp.body)['hits']
    end
end