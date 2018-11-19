class UserMailer < ApplicationMailer
    def send_report(report)
        mail(from: @tutor.email, to: [@tutor.email, @student.email], subject: "We found a tutor for your student!")
    end

end
