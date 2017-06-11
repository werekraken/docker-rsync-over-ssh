docker run -d -v `pwd`/rsync:/rsync -v `pwd`/authorized_keys:/etc/ssh/rsync/authorized_keys -p 2225:22 6fbdf43be4aa
# rsync-over-ssh

## Overview

Dockerfile for rsync over ssh.

## Usage

### Start an rsync-over-ssh instance

```console
$ docker run \
    --name some-rsync-over-ssh \
    -p 192.168.0.254:2222:22 \
    -v /docker/host/dir/authorized_keys:/etc/ssh/rsync/authorized_keys:ro \
    -v /docker/host/dir/rsync:/rsync \
    -d werekraken/dnscache
```

### Use a `Dockerfile` instead of volume for authorized_keys

```dockerfile
FROM werekraken/rsync-over-ssh

COPY authorized_keys /etc/ssh/rsync/authorized_keys
```
