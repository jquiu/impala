class NotificationMailer < ActionMailer::Base
  default from: 'no-responder@impala.com',
          return_path: 'desarrollo@solutek.com.co'

  	def contact_email(email, body)
        @email = email
        @body = body
        mail(to: @email ,from: 'no-responder@impala.com', subject: 'Respuesta Oferta Impala')
    end
end