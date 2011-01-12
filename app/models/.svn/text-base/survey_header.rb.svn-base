class SurveyHeader < Element

	attr_accessor :first_page_only
	attr_accessor :heading
	attr_accessor :picture_url

	def to_s 
		if @first_page_only
			"Survey header - first page only"
		else
			"Survey header - all pages"
		end		
	end

	def initialize
		super
		@heading = "" unless @heading
		@picture_url = "" unless @picture_url
		@first_page_only = false unless @mandatory
	end

	def validation_problems
		problems = super
		problems << "picture url is not valid" if !(@picture_url.blank?) and @picture_url !~ /^([a-zA-Z0-9\-]+\.)+([a-zA-Z0-9\-]+)(:[0-9]+)?(\/([a-zA-Z0-9\-_\.]*))*(\?([^&#\?]+(=[^&#\?]*)?)?(&[^&#\?]+(=[^&#\?]*)?)*)?(#[^&#\?]*)?$/
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