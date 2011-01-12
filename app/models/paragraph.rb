class Paragraph < Element

	attr_accessor :heading
	attr_accessor :text
	attr_accessor :picture_url

	def to_s 
		"Text/image content"
	end

	def initialize
		super
		@heading = "" unless @heading
		@text = "" unless @text
	end

	def validation_problems
		problems = super
		@picture_url = @picture_url.to_s.gsub(/^http:\/\//, "")
		problems << "picture url is not valid" if !(@picture_url.blank?) and @picture_url !~ /^([a-zA-Z0-9\-]+\.)+([a-zA-Z0-9\-]+)(:[0-9]+)?(\/([a-zA-Z0-9\-_\.]*))*(\?([^&#\?]+(=[^&#\?]*)?)?(&[^&#\?]+(=[^&#\?]*)?)*)?(#[^&#\?]*)?$/
		problems;
	end

end