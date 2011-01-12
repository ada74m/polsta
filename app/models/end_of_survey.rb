class EndOfSurvey < Element

	attr_accessor :thankyou_text
	attr_accessor :link_url
	attr_accessor :link_text

	def to_s 
		"End of survey"
	end

	def initialize
		super
		@thankyou_text = "Thank you for completing this survey!" unless @thankyou_text
		@link_url = "polsta.net" unless @link_url
		@link_text = "Go the polsta.net homepage" unless @link_text
	end

	def validation_problems
		problems = super
		problems << "if link text is supplied, so must link url be" if !(@link_text.blank?) and @link_url.blank?
		problems << "link url is not valid" if !(@link_url.blank?) and @link_url !~ /^([a-zA-Z0-9\-]+\.)+([a-zA-Z0-9\-]+)(:[0-9]+)?(\/([a-zA-Z0-9\-_\.]*))*(\?([^&#\?]+(=[^&#\?]*)?)?(&[^&#\?]+(=[^&#\?]*)?)*)?(#[^&#\?]*)?$/
		problems
	end

	def promotable?
		false
	end

	def demotable?
		false
	end

	def deletable?
		false
	end

end