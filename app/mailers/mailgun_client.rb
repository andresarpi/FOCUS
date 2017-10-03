=begin
def simple_mailgun_email
    RestClient.post "https://api:key-51e7eefbf8d505bd2173942f5beab8a7"\
    "@api.mailgun.net/v3/sandbox18e52f1d8d9c488384badd2bb939e5a4.mailgun.org/messages",
    :from => "Mailgun Sandbox <postmaster@sandbox18e52f1d8d9c488384badd2bb939e5a4.mailgun.org>", :to => "Andres <lacuentatruchadeandresarpi@gmail.com>",:subject => "Hello Andres",:text => "This is a mail sent from the console"
end
=end

class MailgunClient
    @@default_api_key = "key-51e7eefbf8d505bd2173942f5beab8a7"
    @@default_domain = "sandbox18e52f1d8d9c488384badd2bb939e5a4.mailgun.org"

    def initialize(domain = nil)
        @api_key = @@default_api_key
        @domain = domain || @@default_domain
    end

    def send_mail(options={})
        response = RestClient.post "https://api:#{@api_key}"\
                        "@api.mailgun.net/v3/#{@domain}/messages",
                        options
         
        return response
    end

    def simple_mailgun_email
        response = RestClient.post "https://api:key-51e7eefbf8d505bd2173942f5beab8a7"\
                                "@api.mailgun.net/v3/sandbox18e52f1d8d9c488384badd2bb939e5a4.mailgun.org/messages",
                                :from => "Mailgun Sandbox <postmaster@sandbox18e52f1d8d9c488384badd2bb939e5a4.mailgun.org>",
                                :to => "Andres <lacuentatruchadeandresarpi@gmail.com>",
                                :subject => "Hello Andres",
                                :text => "Congratulations Andres, you just sent an email with Mailgun!  You are truly awesome!"
        return response
    end
end