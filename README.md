# dockerfile

[![[dwl] ubuntu:14.04 in prod][badge-shields]](https://hub.docker.com/r/davask/d-ubuntu/)
[![[dwl] ubuntu:14.04 license][badge-fossa]](https://app.fossa.io/projects/git%2Bhttps%3A%2F%2Fgithub.com%2Fdavask%2Fd-ubuntu?ref=badge_shield)

[![[dwl] ubuntu:14.04 image][badge-docker]](https://hub.docker.com/r/davask/d-ubuntu/)

[badge-docker]: https://dockeri.co/image/davask/d-ubuntu "[dwl] ubuntu:14.04 image"
[badge-shields]: https://img.shields.io/badge/davask%2Fd--ubuntu-env_prod-brightgreen.svg?style=flat "[dwl] ubuntu:14.04 in prod"
[badge-fossa]: https://img.shields.io/badge/davask%2Fd--ubuntu-license_MIT-brightgreen.svg?style=flat "[dwl] ubuntu:14.04 license"

## Exposed port

- 22
## Default ENV values

- DWL_LOCAL_LANG: 'en_US:en'
- DWL_LOCAL: 'en_US.UTF-8'
- DWL_USER_NAME: 'username'
- DWL_USER_PASSWD: 'secret'
- DWL_USER_ID: '1000'
- DWL_SUDO_USER: 'false'
- DWL_SSH_ACCESS: 'false'
## Available volumes

- /home/host
## LABEL

- dwl.server.os="ubuntu 14.04"

## EXTRA

