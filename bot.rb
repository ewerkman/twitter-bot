require "twitter"
require "pg"

module TwitterBot
    
    def self.conn()
       PG.connect(dbname: 'commerce_tweets') 
    end

    def self.puts_data(tweet)
        puts "Tweet:    #{tweet.id}"
        puts "Text:     #{tweet.text[0..60].gsub(/\s\w+\s*$/,'...')}"
        puts "User:     @#{tweet.user.screen_name} / #{tweet.user.name}"
        puts "Date:     #{DateTime.parse(tweet.created_at.to_s).strftime('%m/%d/%Y')}"
        puts "SINCE_ID: #{get_last_id()}"
        puts "<------------------------>"
    end
    
    def self.set_tweet_id(id, date)
        conn.exec_params("INSERT INTO last_tweet_id (tweet_id, tweet_date) VALUES ($1, $2)", [id, date])
    end
    
    def self.get_last_id()
        last = conn.exec("SELECT tweet_id FROM last_tweet_id ORDER BY tweet_id DESC LIMIT 1")
        if last.ntuples > 0 
            last.getvalue(0,0)
        else
            0
        end
    end
    
    client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["CONSUMER_KEY"]
        config.consumer_secret     = ENV["CONSUMER_SECRET"]
        config.access_token        = ENV["ACCESS_TOKEN"]
        config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
    end
    
    search_term = '("#sitecore") AND ("commerce" OR "commerce server" OR "ecommerce" OR "storefront")'
    
    #client.search(search_term, result_type: "recent", include_entities: true).take(15).each do |tweet|
    client.search(search_term, result_type: "recent", include_entities: true, since_id: get_last_id()).take(15).each do |tweet|
        
        # only post if not a retweet && isn't a paper.li tweet
        if (tweet.retweeted_status.nil?) && !(tweet.urls.first.display_url.include? "paper.li")
            
            # set tweet id and date in DB
            set_tweet_id(tweet.id, DateTime.parse(tweet.created_at.to_s).strftime("%m/%d/%Y"))
            
            # write tweet data
            puts_data(tweet)
            
            # POST TWEET
            client.retweet(tweet)
        end
        
    end
end