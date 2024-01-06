FROM i386/ubuntu:14.04


RUN apt update
RUN apt install -y git python3 python3-pip gcc gcc-multilib g++ g++-multilib

RUN git clone https://github.com/alliedmodders/ambuild /opt/ambuild
RUN python3 -m pip install /opt/ambuild

RUN git clone -b boost-1.71.0 https://github.com/boostorg/boost /opt/boost
WORKDIR /opt/boost
RUN git submodule update --init --recursive

RUN ./bootstrap.sh
RUN ./b2 define=BOOST_TYPE_INDEX_FORCE_NO_RTTI_COMPATIBILITY address-model=32 \
      runtime-link=static link=static --build-dir=build/x86 --stagedir=stage/x86 \
      --with-thread --with-date_time --with-regex

RUN git clone -b 1.6-dev https://github.com/alliedmodders/sourcemod.git /opt/sourcemod
WORKDIR /opt/sourcemod
RUN git submodule update --init --recursive

# For compatibility with old version of sourcemod
RUN ln -s /opt/sourcemod/public/sourcepawn sourcepawn/include

WORKDIR /mnt/project

ENTRYPOINT [ "bash", "build.sh" ]