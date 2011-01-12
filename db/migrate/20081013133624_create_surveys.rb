class CreateSurveys < ActiveRecord::Migration
  def self.up
    create_table :surveys do |t|
		t.string  "name",                                                              :null => false
		t.string  "url_name",                                                          :null => false
		t.integer "user_id",              :limit => 11
		t.integer "responses_count",      :limit => 11, :default => 0
		t.string  "status",               :limit => 20, :default => "never published"
		t.string  "embedding_id",         :limit => 32, :null => true
		t.timestamps
    end
  end

  def self.down
    drop_table :surveys
  end
end
