module DesignHelper


	def command_button (text, command)
		submit_tag text, :name => "cmd:#{command}"
	end

	def action_command_button (text, command) 
		"<input type=\"submit\" value=\"#{h(text)}\" onclick=\"this.form['edit_action'].value = '#{h(command)}';\" class=\"button\"/>"
	end
	

	def edit_button (element)
		submit_tag 'edit', :name => "edit:#{element.id}", :class=>"button"
	end


	def property_textbox(property, value, css_class = "") 
		"<input type=\"text\" name=\"set:#{property}\" value=\"#{h(value)}\" class=\"#{css_class}\" />"
	end

	def property_textarea(property, value) 
		"<textarea name=\"set:#{property}\" class=\"input\">#{h(value)}</textarea>"
	end


	def property_radios (property, options, selected, separator="<br/>")

		s = ""

		options.each do |key, value|
			name = "set:#{property}"
			id = "#{name}:#{key}"
			s << "<input type=\"radio\" "
			s << "name=\"#{name}\" "
			s << "id=\"#{id}\" "
			s << "value=\"#{h(key)}\" "
			s << "checked=\"checked\" " if selected.to_s == key
			s << " />"
			s << " <label for=\"#{id}\">#{value}</label>" << separator
		end
		
		s
	end
	
	def property_checkbox(property, value, label_text) 
		name = "set:#{property}"

		s = ""
		s << "<input type=\"checkbox\" id=\"#{name}\" name=\"#{name}\" "
		s << "checked=\"checked\" " if value
		s << "/>"
		s << " <label for=\"#{name}\">#{label_text}</label>"
		s
	end

end
