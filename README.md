# buildah-molecule-images

![GitHub](https://img.shields.io/github/license/jam82/buildah-molecule-images) ![GitHub last commit](https://img.shields.io/github/last-commit/jam82/buildah-molecule-images) ![GitHub issues](https://img.shields.io/github/issues-raw/jam82/buildah-molecule-images) ![Travis (.com) branch](https://img.shields.io/travis/com/jam82/buildah-molecule-images/main?label=build)

Makefile-based creation of container images with buildah and podman
for automated testing of ansible roles with molecule.

## Supported Platforms

Any linux platform podman and buildah run on.

I use it on Manjaro (based on Archlinux).

## Dependencies

* bash
* buildah
* GNU make
* GNU parallel (optional)
* podman

## Available Images

| Distribution | Version | Image on Docker Hub |
|--------------|---------|---------------------|
| Almalinux | 8 | jam82/molecule-almalinux:8 |
| | Latest | jam82/molecule-almalinux:latest |
| Alpine | 3.11 | jam82/molecule-alpine:3.11 |
| | 3.12 | jam82/molecule-alpine:3.12 |
| | 3.13 | jam82/molecule-alpine:3.13 |
| | Latest | jam82/molecule-alpine:latest |
| Archlinux | Latest | jam82/molecule-archlinux:latest |
| CentOS | 7 | jam82/molecule-centos:7 |
| | 8 | jam82/molecule-centos:8 |
| | Latest | jam82/molecule-centos:latest |
| Debian | 9 | jam82/molecule-debian:9 |
| | 10 | jam82/molecule-debian:10 |
| | 11 | jam82/molecule-debian:11 |
| | Latest | jam82/molecule-debian:latest |
| | Testing | jam82/molecule-debian:testing |
| Fedora | 33 | jam82/molecule-fedora:33 |
| | 34 | jam82/molecule-fedora:34 |
| | Latest | jam82/molecule-fedora:latest |
| | Rawhide | jam82/molecule-fedora:rawhide |
| OpenSuse Leap | 15 | jam82/molecule-opensuse:15 |
| | Latest | jam82/molecule-opensuse:latest |
| OpenSuse Tumbleweed | Latest | jam82/molecule-opensuse:tumbleweed |
| Oracle Linux | 7 | jam82/molecule-oraclelinux:7 |
| | 8 | jam82/molecule-oraclelinux:8 |
| | Latest | jam82/molecule-oraclelinux:latest |
| Ubuntu | 16.04 | jam82/molecule-ubuntu:16.04 |
| | 18.04 | jam82/molecule-ubuntu:18.04 |
| | 20.04 | jam82/molecule-ubuntu:20.04 |
| | Latest | jam82/molecule-ubuntu:latest |

## Usage examples

The term `container registry` in the following examples refers to
the default_registry configured in [images/common](images/common).

### Build all images and push to container registry

```shell
make all
make push
```

### Push images to local docker-daemon for direct use without download

This filters all local podman images built by `$maintainer` and stored as
`localhost/$image:$tag` and pushes them
to `docker-daemon:$maintainer/molecule-$image:$tag`.

```shell
make docker
```

### Build all images in parallel

```shell
make parallel
```

### Build all images of a distribution and push to container registry

For example, to build all Debian images and push them:

```shell
make debian
make push
```

### Build a single image (CentOS 8) and push it to container registry

Call the build script directly:

```shell
./images/centos/8
make push
```

## License and Author

* Author:: jam82 (<jam@kabelmail.net>)
* Copyright:: 2020, jam82

Licensed under MIT License;
See LICENSE file in repository.

## References

* [Buildah Tutorials](https://github.com/containers/buildah/tree/master/docs/tutorials/)
* [Podman Refernce](https://github.com/containers/libpod/tree/master/docs/source/markdown)
