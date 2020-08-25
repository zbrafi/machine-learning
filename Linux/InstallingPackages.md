 # Installing Packages

To install the packages `Tripwire`, `chkrootkit`, `john`  and `Lynis`, we need to use the command `apt` with the following syntax:
    
`sudo apt install <package>`

- Install Tripwire first, following the additional installation steps. 

  - Configure the mail system with "internet site."

  - When asked to select passphrases, and rebuild the configuration and policy files, select `YES`.

  - Create both site and local authentication keys (use `tripwire` for both)


Each time you install a package, `apt` will ask for permission to acquire the disk space needed to install the package.
  
- Use the man pages to find the flag that lets you automatically answer `yes` to any prompts that come up when installing a package:
    -  Run `man apt`

     - The flag is `sudo apt -y install <package name>`.

To install the remaining packages, run the following commands:

- `sudo apt -y install chkrootkit`

- `sudo apt -y install john` 
  
Installing with a single command
    
`sudo apt -y install chkrootkit lynis john`

