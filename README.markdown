# slicehost-tools

Manage Slicehost Slices and DNS records/zones from the command line. 

## WARNING

I am not responsible if this eats your data, destroys your life, and sleeps with your wife. YOU HAVE BEEN WARNED.

## Installation

git clone git://github.com/wycats/thor.git  
git clone git://github.com/cameroncox/slicehost-tools.git  

    cd thor
    rake install
    cd ..
    cd slicehost-tools
    rake gem
    sudo gem install --local pkg/slicehost-tools-0.0.3.gem

## Usage

slicehost-dns

    add [DOMAIN] [IP]    add a domain for the given ip
    list                 lists all zones and their associated records
    delete [DOMAIN]      removes a domain
    apikey [APIKEY]      set your Slicehost API Key and save it to ~/.slicehost-tools
    help [TASK]          describe available tasks or one specific task

slicehost-slice

    add [SLICE NAME] [--force]      add a new slice
    delete [SLICE]                  delete a slice
    list                            list slices
    hard_reboot [SLICE]             perform a hard reboot
    soft_reboot [SLICE]             perform a soft reboot
    apikey [APIKEY]                 set your Slicehost API Key and save it to ~/.slicehost-tools
    help [TASK]                     describe available tasks or one specific task


## TODO

[DONE] Finish up the slice tool  
Multiple Slicehost accounts? (not likely, but an idea)         