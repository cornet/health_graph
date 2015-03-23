module HealthGraph
  class User
    include Model
          
    hash_attr_accessor :userID
     
    def initialize(access_token)            
      self.access_token = access_token
      response = get "user", HealthGraph.accept_headers[:user]
      if response.body.reason
        raise response.body.reason
      end
      self.body = response.body
      populate_from_hash! self.body      
    end
        
    def profile      
      HealthGraph::Profile.new self.access_token, self.body["profile"]      
    end        
    
    def settings
      HealthGraph::Settings.new self.access_token, self.body["settings"]
    end

    def nutrition(params={})
      HealthGraph::NutritionFeed.new self.access_token, self.body["nutrition"], params
    end

    def background_activities(params={})
      HealthGraph::BackgroundActivitiesFeed.new self.access_token, self.body["background_activities"], params
    end
    
    def weight(params={})
      HealthGraph::WeightFeed.new self.access_token, self.body["weight"], params
    end

    def general_measurements(params={})
      HealthGraph::GeneralMeasurementFeed.new self.access_token, self.body["general_measurements"], params
    end
    
    def diabetes(params={})
      HealthGraph::DiabetesFeed.new self.access_token, self.body["diabetes"], params
    end
    
    def sleep(params={})
      HealthGraph::SleepFeed.new self.access_token, self.body["sleep"], params
    end
    
    def fitness_activities params = {}
      HealthGraph::FitnessActivitiesFeed.new self.access_token, self.body["fitness_activities"], params
    end
    
    def new_fitness_activity params
      HealthGraph::NewFitnessActivity.new self.access_token, params
    end
    
    def fitness_activity_update params
      HealthGraph::FitnessActivityUpdate.new self.access_token, params
    end

    def fitness_activity_delete params
      HealthGraph::FitnessActivityDelete.new self.access_token, params
    end

    def fitness_activity params
      HealthGraph::FitnessActivity.new self.access_token, params['uri'], params
    end
    
    def strength_training_activities params = {}
      HealthGraph::StrengthTrainingActivitiesFeed.new self.access_token, self.body["strength_training_activities"], params
    end
  end
end
