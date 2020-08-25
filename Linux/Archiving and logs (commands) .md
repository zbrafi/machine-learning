# Archiving and Logging Data 


### `tar`: Create, extract, compress, and manage tar backup archives

Command to **extract** the `TarDocs.tar` archive to the current directory:

- 'sudo tar xvvf TarDocs.tar'

Command to **create** the `Javaless_Doc.tar` archive from the `TarDocs/` directory, while excluding the `TarDocs/Documents/Java` directroy:

- 'sudo tar cvvWf Javaless_Docs.tar --exclude 'Java/*' --exclude Java TarDocs'

Ensuring `Java/` is not in the new `Javaless_Docs.tar` archive:

- 'sudo tar tvvf Javaless_Docs.tar | grep Java'

#### `tar` Critical Thinking

Why wouldn't you use the options `-x` and `-c` at the same with `tar`?

-x [Extract]
-c [create]

As they both are '-Acdtrux', tar command does not take more than one '-Acdtrux', i.e. '--delete' or  '--test-label' option. 


### `cron`: Create, manage and automate various cron jobs

Cron job for backing up the `/var/log/auth.log` file:

- '0 6 * * 3 tar cvzf /var/log/auth_backup.tgz /var/log/auth.log >/dev/null 2>&1'

---

### `bash scripting`: Write basic bash scripts

Brace expansion command to create the four subdirectories:

- 'mkdir backups && mkdir ~/backups/{freemem,diskuse,openlist,freedisk}'

Command and file edit to create `system.sh` (you can copy and paste it here):

- nano ~/system.sh -- to open the file
- ^x -- within the nano file to exit the file
- ^x -- to save the changes made before exiting the file. Can also be use to modify the name

- Within the script, have the following: (script attached)

    ```bash
    #!/bin/bash
    `
# Free memory output to a free_mem.txt file
free -h > ~/backups/freemem/free_mem.txt

# Disk usage output to a disk_usage.txt file
sudo du / -h > ~/backups/diskuse/disk_usage.txt

# List open files to a open_list.txt file
lsof > ~/backups/openlist/open_list.txt

# Free disk space to a free_disk.txt file
df -h > ~/backups/freedisk/free_disk.txt
`
    ```

Command to make the `system.sh` script executable:

- sudo chmod +x system.sh

Commands to to confirm script's execution: (you may use less instead of cat for some files)

- cat ~/backups/freedisk/free_disk.txt 

- cat ~/backups/diskuse/disk_usage.txt

- cat ~/backups/openlist/open_list.txt

- cat ~/backups/freedisk/free_disk.txt

Command to copy `system` to system-wide cron directory:

- `@weekly /home/sysadmin/system.sh` -- by editing the crontab
-  sudo cp ~/system.sh /etc/cron.weekly -- by adding the script to the weekly folder

---

### `journalctl`: Perform various log filtering techniques

Command to return `journalctl` messages with priorities from emergency to error:

- 'sudo journalctl -p err -b -0'

Command to return `systemd-journald` messages:

- 'sudo journalctl -u systemd-journald -b 0 | less'

Comand to prune archived journal files except the most recent 2:

- 'sudo journalctl --vacuum-files=2'

Command to filter all log messages with priority levels between 0 and 2, output to `/home/sysadmin/Priority_High.txt`

- 'sudo journalctl -p 2 >> /home/sysadmin/Priority_High.txt'

 Command and file edit to automate the last command in a daily cronjob: (not sure which last task were asked so I did that for both)

- @daily sudo journalctl --vacuum-files=2
- @daily sudo journalctl -p 2 > /home/sysadmin/Priority_High.txt

- crontab -e  [to open the crontab file]
- ^x [to save the changes made]

- Within the `crontab` file, add the following:

    ```bash
    @daily sudo journalctl -p 2 >> /home/sysadmin/Priority_High.txt
    ```

---

### `rsyslog`: Priority based log file creation

Command and file edit to record all `mail` log messages, except for `debug` to `/var/log/mail.log`:

  - run 'sudo nano /etc/rsyslog.d/50-default.conf' to edit the `rsyslog` config file

    under the `mail.err` add 'mail.!debug /var/log/mail.log'

- Add within the configuration file:
    
    ```bash
    `mail.!debug                        /var/log/mail.log` 
    ```

Command and file edit to record all `boot` log messages, except for `info` and `debug` to `/var/log/boot.log`:

- `run 'sudo nano /etc/rsyslog.d/50-default.conf' to edit the `rsyslog` config file

- and 'boot.!info,!debug /var/log/boot.log'

- Add within the configuration file:

    ```bash
    `boot.!info,!debug                  /var/log/boot.log`
    ```

---

### `logrotate`: Manage log file sizes

Command and file edit that backs up authentication messages to `/var/log/auth.log`:

- Run `sudo nano /etc/logrotate.conf` to edit the `logrotate` configuration file.

- Add within the configuration file:

    ```bash
    `/var/log/auth.log {
    rotate 7
    weekly
    notifempty
    delay compression
    compress
    missingok
    Endscript 
    }`
    ```

---

### Check `auditd`: Check for policy and file violations.

Command to verify `auditd` is active:

- 'systemctl status auditd'

Command and file edit to set number of retained logs and maximum log file size:

- `Run `sudo nano /etc/audit/audit.conf` to edit the `auditd` config file 

- Add within the configuration file:

- Log file location should already be `/var/log/audit/audit.log`.
	
    ```bash
	log_file = /var/log/audit/audit.log
	```
	
    - Number of retained logs is `7`
	```bash
	num_logs = 7
	```

	- Maximum log file size is `35`.
	```bash
    max_log_file = 35
    ```

Command and file edit using `auditd` itself to set rules for `/etc/shadow`, `/etc/passwd` and `/var/log/auth.log`:

- `run `sudo nano /etc/audit/rules.d/audit.rules` to edit the `rules` for `auditd` and create rules`

- Add within the `rules` file:

    ```bash
    -w /etc/shadow -p wa -k shadow
    -w /etc/passwd -p wa -k passwd
    ```

Command to restart `auditd`:

- 'sudo systemctl restart auditd'

Command to list all `auditd` rules:

- 'sudo auditctl -l'

Command to produce an audit report:

- 'sudo aureport -au'

Command to use `auditd` to watch `/var/log/cron`:

- 'sudo auditctl -w /var/log/cron'

Command to re-verify `auditd` rules:

- 'sudo auditctl -l'
