#
class Version < ActiveRecord::Base
	has_many :responses
	belongs_to :survey
	acts_as_list :scope => :survey
	serialize :design, Design
	
	def publish!
		# if there's aready a live one, archive it
		already_live = self.survey.live_version
		if already_live
			already_live.archive! false
		end

		self.state = 2
		self.save!

		new_version = Version.new
		new_version.design = self.design
		self.survey.versions << new_version
		new_version.save!

		survey.status = "version #{self.position} live"
		survey.save!
	end

	def archive! (set_survey_status = true)
		self.state = 3
		self.save!
		
		if set_survey_status
			survey.status = "version #{self.position} archived"
			survey.save!
		end
	end

end
