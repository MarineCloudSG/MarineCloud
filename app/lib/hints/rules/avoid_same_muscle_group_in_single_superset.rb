module Hints
  module Rules
    class AvoidSameMuscleGroupInSingleSuperset
      def initialize(training_data, _profile_data)
        @training_data = training_data
      end

      def references
        supersets.flat_map do |superset|
          repeating_muscle_group_ids_for(superset).map do |muscle_group_id|
            superset.exercises.select do |exercise|
              exercise.muscle_group_ids.include?(muscle_group_id)
            end.map(&:position)
          end
        end
      end

      private

      attr_reader :training_data

      def supersets
        SupersetsCollection.new(training_data)
      end

      def repeating_muscle_group_ids_for(superset)
        muscle_group_ids = superset.exercises.flat_map(&:muscle_group_ids)
        muscle_group_ids.
          group_by(&:itself).
          reject { |_k, v| v.size == 1 }.
          keys
      end
    end
  end
end
