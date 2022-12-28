# Squid
You will need to generate the `passwords` file with the `htpasswd` command:
```
htpasswd -c ./passwords username
```

# VPNC
You will need to generate the vpnc file.  It should look like this:
```
IPSec gateway <gateway domain>
IPSec ID <IPSec ID>
IPSec secret <IPSec Secret>
IKE Authmode psk
Xauth username <Username usually from a RADIUS auth service, such as Active Directory>
Xauth password <Matching Password for the above username>
```

Install docker and docker-compose, or docker for desktop and run `docker compose up`/`docker-compose up`
