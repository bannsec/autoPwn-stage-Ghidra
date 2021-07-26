FROM ubuntu:focal

# One layer for any lib updates
RUN apt update && apt dist-upgrade -y && apt install -y wget unzip xauth libxtst6 libxi6 libxrender1 x11-apps openjdk-11-jdk

# Specific layer for Ghidra
RUN mkdir -p /opt && cd /opt && \
    GHIDRA_ZIP=`wget -O- --quiet https://github.com/NationalSecurityAgency/ghidra/releases/latest | grep href | grep zip | grep download | sed 's/^.*href="\(\S\+\)".*$/\1/g'` && \
    wget -O ghidra.zip --quiet https://github.com/${GHIDRA_ZIP} && unzip ghidra.zip && rm ghidra.zip

# Bash mod layer
RUN cd /opt/gh* && echo export PATH=\$PATH:$PWD:$PWD/server:$PWD/support >> ~/.bashrc

CMD /bin/bash -i -c "/opt/ghidra*/support/launch.sh fg Ghidra \"2G\" \"\" ghidra.GhidraRun \"\""
