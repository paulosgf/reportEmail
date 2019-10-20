# reportEmail
Ruby plugin for send Metasploit's scan reports attached to email.

It works with my other Metasploit's project to create PDF reports of scans:
https://github.com/paulosgf/metasploitReportTemplate

For Gmail accounts, configure then to receive emails from this plugin in:
https://www.google.com/settings/security/lesssecureapps and
https://accounts.google.com/DisplayUnlockCaptcha

If your account uses 2fa, e.g. Google-Auth, then access this:
https://myaccount.google.com/apppasswords

Use:
load reportEmail
reportemail "User Name" "username@gmail.com" "password"
