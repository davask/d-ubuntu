# dockerfile

## Open port
- 22

## Default ENV values

### Define Default LANG LOCAL
> DWL_LOCAL en_US.UTF-8

### Define username:passwd for ssh access
> DWL_USER_NAME username

> DWL_USER_PASSWD secret

### Define if ssh and sftp access are accepted
> DWL_SSH_ACCESS false

## LABEL
> dwl.server.os="ubuntu 14.04"
