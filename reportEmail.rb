#################################################################
# This module requires Metasploit: http://metasploit.com/download
# Current source: https://github.com/rapid7/metasploit-framework
##################################################################
#
# It requires Gmail Library:
# gem install gmail	Or
# git clone git://github.com/gmailgem/gmail.git
# cd gmail
# make install
#

module Msf

require 'net/smtp'

class Plugin::ReportEmail < Msf::Plugin

	class ConsoleCommandDispatcher
	include Msf::Ui::Console::CommandDispatcher

#
# The dispatcher’s name.
#
def name
"ReportEmail"
end
#
# Returns the hash of commands supported by this dispatcher.
#
def commands
{
"reportemail" => "An unique command added by the ReportEmail plugin"
}
end
#
# This method handles the sample command.
#
def cmd_reportemail(name, email, password)
time1 = Time.now
time2 = time1.inspect
filename = "/root/192.168.0.116.pdf"
file_content = File.read(filename)
encoded_content = [file_content].pack("m")	

marker = "AUNIQUEMARKER"

part1 = <<-END_OF_MESSAGE
From: #{name} <#{email}>
To: #{name} <#{email}>
Subject: New node found - 5
Date: #{time2}
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary = #{marker}
--#{marker}
END_OF_MESSAGE

part2 = <<-END_OF_MESSAGE
Content-Type: text/html
Content-Transfer-Encoding:8bit

<html>
<head></head>
<body>
<h4>Scan report for new node 5.</h4>
<p></p>
Happy hacking!
</body>
</html>
--#{marker}
END_OF_MESSAGE

part3 = <<-END_OF_MESSAGE
Content-Type: multipart/mixed; name = "#{filename}"
Content-Transfer-Encoding:base64
Content-Disposition: attachment; filename = "#{filename}"

#{encoded_content}
--#{marker}--
END_OF_MESSAGE

message = part1 + part2 + part3
smtp = Net::SMTP.new('smtp.gmail.com', 587)
smtp.set_debug_output $stderr
smtp.enable_starttls
smtp.start('localhost', "#{email}", "#{password}", :plain) do |smtp|
  smtp.send_message "#{message}",
  "#{email}",
  "#{email}"
end
print_line("Sending report email to: #{email}")
end
end
#
# The constructor is called when an instance of the plugin is created. The
# framework instance that the plugin is being associated with is passed in
# the framework parameter. Plugins should call the parent constructor when
# inheriting from Msf::Plugin to ensure that the framework attribute on
# their instance gets set.
#
def initialize(framework, opts)
super
# If this plugin is being loaded in the context of a console application
# that uses the framework’s console user interface driver, register
# console dispatcher commands.
add_console_dispatcher(ConsoleCommandDispatcher)
print_status("ReportEmail plugin loaded.")
end
#
# The cleanup routine for plugins gives them a chance to undo any actions
# they may have done to the framework. For instance, if a console
# dispatcher was added, then it should be removed in the cleanup routine.
#
def cleanup
# If we had previously registered a console dispatcher with the console,
# deregister it now.
remove_console_dispatcher('ReportEmail')
end
#
# This method returns a short, friendly name for the plugin.
#
def name
"reportemail"
end
#
# This method returns a brief description of the plugin.
# more than 60 characters, but there are no hard limits.
#
def desc
"Framework plugin for sending email reports"
end
end
end

