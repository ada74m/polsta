class Address
	attr_accessor :line1
	attr_accessor :line2
	attr_accessor :line3
	attr_accessor :line4
	attr_accessor :line5

	def initialize (l1, l2, l3, l4, l5)
		@line1 = l1;
		@line2 = l2;
		@line3 = l3;
		@line4 = l4;
		@line5 = l5;
	end

	def to_s 
		out = ""
		out += @line1 + "\n" if @line1
		out += @line2 + "\n" if @line2
		out += @line3 + "\n" if @line3
		out += @line4 + "\n" if @line4
		out += @line5 + "\n" if @line5
		out.chomp
	end
	
	def empty? 
		(@line1.empty? && @line2.empty? && @line3.empty? && @line4.empty? && @line5.empty?)
	end

end