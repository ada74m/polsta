class CreateVersions < ActiveRecord::Migration
	def self.up
		create_table :versions do |t|
			t.integer "survey_id",            :limit => 11,                :null => false
			t.integer "position",             :limit => 11
			t.integer "state",                :limit => 11, :default => 1
			t.text    "design"
			t.integer "responses_count",      :limit => 11, :default => 0
			t.timestamps
		end
	end
	
	def self.down
		drop_table :versions
	end
end
