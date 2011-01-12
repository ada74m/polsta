class AddRssIdToSurvey < ActiveRecord::Migration
  def self.up
    add_column "surveys", "rss_id", :string, :limit => 32, :null => true
  end

  def self.down
  	remove_column "surveys", "rss_id"
  end
end
