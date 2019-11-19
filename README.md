MSP430-GCC Docker Image
=======================

Ubuntu-based Docker image equipped with MSP430-GCC, CMake, Doxygen and Sphinx.
Use it in your CI environment to test builds for MSP430 devices and build and
deploy Doxygen/Sphinx documentation.

Build locally
-------------

You can use the provided Dockerfile (and make local modifications to it) to
build an image locally as well:

```
$ git clone https://github.com/cdelledonne/docker-msp430-gcc.git
$ cd docker-msp430-gcc
$ docker build --no-cache --pull -t cdelledonne/msp430-gcc:latest .
```
