module HealthGraph
  class FitnessActivity
    include Model              

    # hash_attr_accessor :items, :next, :previous, :size

    attr_accessor :paths, :distances

    hash_attr_accessor :climb, :nearest_teammate_weight, :equipment, :type, :distance, :share, :nearest_teammate_strength_training_activities,
      :nearest_teammate_diabetes, :path, :calories, :total_calories, :activity, :nearest_weight, :total_distance, :previous, 
      :nearest_teammate_sleep, :nearest_teammate_fitness_activities, :uri, :nearest_teammate_general_measurements, :utc_offset,
      :userID, :duration, :average_heart_rate, :heart_rate, :source, :entry_mode, :start_time, :images, :is_live, :nearest_temamate_background_activities,
      :share_map, :notes, :comments

    class Path
      include Model

      hash_attr_accessor :timestamp, :altitude, :longitude, :latitude, :type

      def initialize(hash) 
        populate_from_hash! hash
      end 

    end

    class Distance
      include Model

      hash_attr_accessor :timestamp, :distance

      def initialize(hash) 
        populate_from_hash! hash
      end 

    end


    class Item 
      include Model      

      def initialize(hash) 
        populate_from_hash! hash
      end      
    end

    def initialize(access_token, path, params = {})            
      self.access_token = access_token
      response = get path, HealthGraph.accept_headers[:fitness_activity], params
      self.body = response.body
      populate_from_hash! self.body
      self.paths = self.path.map {|x| Path.new(x)}
      self.distances = self.distance.map {|x| Distance.new(x)}
    end                           
  end
end
