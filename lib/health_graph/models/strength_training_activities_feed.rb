module HealthGraph
  class StrengthTrainingActivitiesFeed
    include Model              
    
    hash_attr_accessor :items, :next, :previous, :size
    
    class Item
      include Model 
      
      hash_attr_accessor :start_time, :uri
      
      def initialize(hash) 
        populate_from_hash! hash
      end      
    end
                      
    def initialize(access_token, path, params = {})            
      self.access_token = access_token
      response = get path, HealthGraph.accept_headers[:strength_training_activity_feed], params
      if response.body.reason
        raise response.body.reason
      end
      self.body = response.body
      populate_from_hash! self.body
    end
    
    def next_page
      StrengthTrainingActivitiesFeed.new(self.access_token, self.next) if self.next
    end
  end
end