#!/bin/bash
# Copyright (C) 2019 Zilliqa
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
# This script is dedicated for CI use
#

apt update -y

# APT packages are organized into two groups, build dependency and
# development dependency, where the former is necessary for users who
# want to build Zilliqa whereas the latter is only for CI.
# Note that the names are sorted in each group.
#
# Build dependency
apt install -y build-essential \
    cmake \
    libboost-filesystem-dev \
    libboost-program-options-dev \
    libboost-system-dev \
    libboost-test-dev \
    libboost-python-dev \
    libcurl4-openssl-dev \
    libevent-dev \
    libjsoncpp-dev \
    libjsonrpccpp-dev \
    libleveldb-dev \
    libmicrohttpd-dev \
    libminiupnpc-dev \
    libsnappy-dev \
    libssl-dev \
    cargo \
    pkg-config \
    wget

# Development dependency
apt install -y ccache \
    clang-5.0 \
    clang-format-5.0 \
    clang-tidy-5.0 \
    curl \
    gawk \
    git \
    lcov \
    libxml2-utils \
    python-dev \
    python3-dev \
    libsecp256k1-dev

wget https://github.com/Kitware/CMake/releases/download/v3.19.3/cmake-3.19.3-Linux-x86_64.sh
mkdir -p `pwd`/.local
bash ./cmake-3.19.3-Linux-x86_64.sh --skip-license --prefix=`pwd`/.local/
mv /usr/bin/cmake{,.old} && ln -s `pwd`/.local/bin/cmake /usr/bin/
cmake --version
rm cmake-3.19.3-Linux-x86_64.sh
ls /scilla/0/

cd /home/jenkins/agent/workspace/zilliqaci && ./scripts/ci_build.sh && \
# Code coverage is currently only implemented for GCC builds, so OSX is currently excluded from reporting
./scripts/ci_report_coverage.sh