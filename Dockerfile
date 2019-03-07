FROM ubuntu:bionic

# One layer for any lib updates
RUN apt update && apt dist-upgrade -y && apt install -y wget unzip xauth libxtst6 libxi6 libxrender1 x11-apps

# Specific layer for Ghidra
RUN mkdir -p /opt && cd /opt && \
    GHIDRA_ZIP=`wget -O- --quiet https://ghidra-sre.org/ | grep href | grep zip | sed 's/^.*href="\(\S\+\)".*$/\1/g'` && \
    wget -O ghidra.zip https://ghidra-sre.org/${GHIDRA_ZIP} && unzip ghidra.zip && rm ghidra.zip

# Specific layer for Java
RUN cd /opt && \
    OPENJDK_URL=`wget -O- --quiet http://jdk.java.net/11/ | grep -oie 'https://.*linux.\+.tar.gz' | head -1` && \
    wget -O openjdk.tar.gz $OPENJDK_URL && tar xf openjdk.tar.gz && rm openjdk.tar.gz

# Bash mod layer
RUN cd /opt/gh* && echo export PATH=\$PATH:$PWD:$PWD/server:$PWD/support >> ~/.bashrc && \
    cd /opt/jdk*/bin && echo export PATH=\$PATH:$PWD >> ~/.bashrc

CMD /bin/bash -i -c "/opt/ghidra*/support/launch.sh fg Ghidra \"2G\" \"\" ghidra.GhidraRun \"\""
