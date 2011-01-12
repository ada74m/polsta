class Survey < ActiveRecord::Base
	has_many :versions
	belongs_to :user
	validates_uniqueness_of :name, :scope => :user_id
	validates_length_of :name, :within=>3..50

	before_create :set_url_name
	before_create :set_embedding_and_rss_ids

	def live_version
		for version in versions
			return version if version.state == 2
		end
		nil
	end
	
	def version_in_design
		for version in versions
			return version if version.state == 1
		end
		nil
	end

	private

	def set_embedding_and_rss_ids 
		self.embedding_id = newid
		self.rss_id = newid
	end

	def set_url_name
		prefix = ((self.name.downcase.gsub /[^a-z0-9]/, "-").gsub /-+/, "-").gsub /-$/, ""
		url_name = prefix

		suffix = 1
		while !Survey.find(:first, :conditions => ["url_name=? and user_id=?", url_name, self.user_id]).blank?
			url_name = "#{prefix}-#{suffix.to_s}"
			suffix += 1
		end

		self.url_name = url_name

	end	


	def newid 
		Digest::MD5.hexdigest("#{Time.new.to_i} #{Time.new.usec} #{Kernel.rand}")
	end


end
