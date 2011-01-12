class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
		t.string  "email",                                               :null => false
		t.string  "account_name",                                        :null => false
		t.string  "password_salt"
		t.string  "password_hash"
		t.integer "credits",                :limit => 11, :default => 0, :null => false
		t.integer "has_accepted_terms",     :limit => 11, :default => 0, :null => false
		t.integer "wishes_to_receive_news", :limit => 11, :default => 0, :null => false
    	t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
