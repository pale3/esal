Inspired by gentoo eselect utility

for now there is no special method for installing. I'll change this when I get a time.

after installation, there is one more step which you need to take before altering your 
environment variables.

in /etc/profile at the ned of file add line
	source /etc/env.conf
if error occurred while sourcing file or upon rereading /etc/profile, just ignore it, with root permissions and using esal this file will be automatically created and error will disappear.

for testing purpose just clone this repo, 
edit ES_DATA_PATH="/usr/lib/esal" to your esal main dir

for more information exec esal.
