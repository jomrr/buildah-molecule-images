# buildah-molecule-images

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

## Usage

TODO

## Examples

### Build all images and push to container registry

```shell
make all
make push
```

### Build all images in parallel

```shell
make parallel
```

### Build all images of a distribution

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

* Author:: Jonas Mauer (<jam@kabelmail.net>)
* Copyright:: 2020, Jonas Mauer

Licensed under MIT License;
See LICENSE file in repository.

## References

* [Buildah Tutorials](https://github.com/containers/buildah/tree/master/docs/tutorials/)
* [Podman Refernce](https://github.com/containers/libpod/tree/master/docs/source/markdown)
