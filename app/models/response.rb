class Response < ActiveRecord::Base

	belongs_to :version
	serialize :answers
	before_create :set_guid

	def Response.for_version(version, remote_ip) 
		Response.new(:version=>version, :remote_ip=>remote_ip, :answers=>{})
	end

	def set_answer(question, value)
		answers[question.id] = value
	end
	
	def get_answer(question)
		answers[question.id]
	end
	
	def summary

    design = version.design
    
    questions = design.response_column_headers
    answers = []
    
    for q in design.questions
    	answers += q.response_columns(self.answers) 
    end
    
    answers = (0...questions.size).map { |i| [questions[i], answers[i]] }
    
    "<table border=\"1\">" + answers.map{|a| "<tr><td>#{a[0]}</td><td>#{a[1]}"}.join("</td></tr>") + "</table>"
    

  end

	protected 
	
	def after_create
		version.responses_count +=1
		version.save!
		version.survey.responses_count += 1
		version.survey.save!
	end
	
	def after_destroy
		version.responses_count -=1
		version.survey.responses_count -= 1
	end


	protected
	
	def set_guid
		self.guid = Digest::MD5.hexdigest("#{Time.new.to_i} #{Time.new.usec} #{Kernel.rand}")
	end

end
