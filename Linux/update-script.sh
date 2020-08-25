# This script is used to update the VM on VirtualBox (Bootcamp)

#!/bin/bash
cd /Users/zrafi/Documents/Cybersecurity-Bootcamp/Linux-Module
vagrant box update
vagrant destory --force
vagrant up
