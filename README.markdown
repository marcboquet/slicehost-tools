# slicehost-tools

Manage Slicehost Slices and DNS records/zones from the command line. 

## WARNING

I am not responsible if this eats your data or destroys your life. YOU HAVE BEEN WARNED.

## Installation

	gem sources -a http://gems.github.com
	
	sudo gem install thor
	sudo gem install booster-slicehost-tools

## Usage

slicehost-dns

    add [DOMAIN] [IP]                  add a domain for the given ip
    google_apps [DOMAIN] [IP]          configure Google Apps for the given domain (new or existing)
    add_a [DOMAIN] [NAME] [IP]         add a A record to an existing domain
    add_assets [DOMAIN] [IP]           add a 4 assets hosts (assets0..assets3) to an existing domain
    add_cname [DOMAIN] [NAME] [CNAME]  add a CNAME record to an existing domain
    list                               lists all zones and their associated records
    delete [DOMAIN]                    removes a domain
    apikey [APIKEY]                    set your Slicehost API Key and save it to ~/.slicehost-tools
	to_zonefile [DOMAIN]			   output a zone file for the given domain
    help [TASK]                        describe available tasks or one specific task

slicehost-slice

    add [SLICE NAME] [--force]         add a new slice
    delete [SLICE]                     delete a slice
    list                               list slices
    hard_reboot [SLICE]                perform a hard reboot
    soft_reboot [SLICE]                perform a soft reboot
    apikey [APIKEY]                    set your Slicehost API Key and save it to ~/.slicehost-tools
    help [TASK]                        describe available tasks or one specific task

## Contributing

Feel free to fork and send pull requests via github. 