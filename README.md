# reportEmail
Ruby plugin for send Metasploit's scan reports attached to email (Gmail for default).

It works with my other Metasploit's project to create PDF reports of scans:
https://github.com/paulosgf/metasploitReportTemplate

For Gmail accounts, configure then to receive emails from this plugin in:
https://www.google.com/settings/security/lesssecureapps 
and
https://accounts.google.com/DisplayUnlockCaptcha

If your account uses 2fa, e.g. Google-Auth, then access this:

https://myaccount.google.com/apppasswords

Use:

mkdir –p $HOME/.msf4/plugins

cp reportEmail.rb $HOME/.msf4/plugins

msf > load reportEmail

msf > reportemail "target name or IP" (without quotation marks)

If the email credentials file doesn't exist yet, then the program prompt you to give them, for example:

username:
Jon Doe

email:
jondoe@gmail.com

password:
foobar

... then it saves on /root/.msf4/plugins/.emailCreds.yaml configuration file, for the next times.

That's it!
