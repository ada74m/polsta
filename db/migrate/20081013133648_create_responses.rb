class CreateResponses < ActiveRecord::Migration
	def self.up
		create_table :responses do |t|
			t.integer  "user_id",    :limit => 11
			t.string   "guid",       :limit => 32,                :null => false
			t.integer  "version_id", :limit => 11,                :null => false
			t.text     "answers",                                 :null => false
			t.string   "remote_ip",  :limit => 40,                :null => false
			t.timestamps
		end
	end

	def self.down
		drop_table :responses
	end
end
