FROM ubuntu:bionic

# Install base packages
RUN apt-get update && \
        apt-get install -y apt-utils ssh git wget build-essential zlib1g-dev \
        ca-certificates apt-transport-https gnupg software-properties-common \
        python3-pip unzip

# Install CMake
RUN wget -O - "https://apt.kitware.com/keys/kitware-archive-latest.asc" 2>/dev/null | apt-key add - && \
        apt-add-repository "deb https://apt.kitware.com/ubuntu/ bionic main" && \
        apt-get update && \
        apt-get install -y cmake

# Install MSP430-GCC and support files
ENV MSP430_GCC_VERSION 8.3.0.16
RUN mkdir -p /opt/ti
RUN wget "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/latest/exports/msp430-gcc-${MSP430_GCC_VERSION}_linux64.tar.bz2" && \
        wget "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/latest/exports/msp430-gcc-support-files-1.208.zip" && \
        tar xf msp430-gcc-${MSP430_GCC_VERSION}_linux64.tar.bz2 && \
        unzip msp430-gcc-support-files-1.208.zip && \
        mv msp430-gcc-${MSP430_GCC_VERSION}_linux64 /opt/ti/msp430-gcc && \
        mv msp430-gcc-support-files/include /opt/ti/msp430-gcc/include && \
        rm msp430-gcc-${MSP430_GCC_VERSION}_linux64.tar.bz2 && \
        rm msp430-gcc-support-files-1.208.zip && \
        rm -rf /opt/ti/msp430-gcc-support-files
ENV PATH /opt/ti/msp430-gcc/bin:$PATH
ENV CPATH /opt/ti/msp430-gcc/include:$CPATH
ENV CPATH /opt/ti/msp430-gcc/msp430-elf/include:$CPATH
ENV LIBRARY_PATH /opt/ti/msp430-gcc/bin:$LIBRARY_PATH

# Install Doxygen
RUN apt-get install -y doxygen

# Install Sphinx and related modules
RUN pip3 install sphinx breathe sphinx-rtd-theme
