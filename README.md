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
Use `docker-compose up -d` to daemonise the services so they are available on startup

# SSH
An `authorised_keys` file needs to be created with uid and gid of 4096 (to match the docker user's uid and gid)
Cat your public key file into this file so that you can access the bastion (test with `ssh bastion@127.0.0.1 -p2222`)

You can then update your config file and add the bastion into your config (I suggest using ProxyJump as it simplifies the config):
```
Host my-remote-server.example.com
  User someusername
  ProxyJump bastion@127.0.0.1:2222,someusername@some-other-remote-server.some-region.example.com
```

# Squid
You will need to generate the `passwords` file with the `htpasswd` command:
```
htpasswd -c ./passwords <username>
```
This will result in a file with the name `passwords` in the current directory.  The contents of this file will be in the format:
```
<username>:$apr1$<salt>$<hash>
```

# Kubernetes
You can change your kubeconfig to use the bastion as a proxy for all clusters.
* Just add proxy-url key to each cluster in your kubeconfig clusters array
    - the proxy-url format is `http://<htpassword username>:<password set with htpassword>@127.0.0.1:8080`

# Terraform
You can use the Squid proxy to route Terraform requests through the VPN much like with Kubernetes but the execution is a little different.
* You will need to set the `HTTP_PROXY` and `HTTPS_PROXY` environment variables to `http://<htpassword username>:<password set with htpassword>@localhost:8080`
```
# either:
export HTTP_PROXY=http://<htpassword username>:<password set with htpassword>@localhost:8080
export HTTPS_PROXY=http://<htpassword username>:<password set with htpassword>@localhost:8080
# or:
HTTP_PROXY=http://<htpassword username>:<password set with htpassword>@localhost:8080 \
HTTPS_PROXY=http://<htpassword username>:<password set with htpassword>@localhost:8080 terraform ...
```
