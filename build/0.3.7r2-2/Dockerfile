FROM debian:bookworm-slim

# SA-MP server executable is a x86 application only
RUN dpkg --add-architecture i386

# Install packages
RUN apt-get update && apt-get install -y \
 lib32stdc++6 \
 wget \
 psmisc

# Download and extract server files
# Choose a more general directory name which does not contain any version
RUN wget https://github.com/cngil/samp-files/blob/master/archives/samp037svr_R2-2-1.tar.gz?raw=true -O samp037svr_R2-2-1.tar.gz\
 && tar xzf samp037svr_R2-2-1.tar.gz \
 && rm -f samp037svr_R2-2-1.tar.gz \
 && mv /samp03 /samp-svr \
 && cd samp-svr \
 && rm -rf include npcmodes/*.pwn filterscripts/*.pwn gamemodes/*.pwn \
 && mv samp03svr samp-svr \
 && chmod 700 *

COPY samp.sh /usr/local/bin/samp
COPY docker-entrypoint.sh /entrypoint.sh

RUN chmod +x /usr/local/bin/samp \
 && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["samp", "start"]

EXPOSE 7777/udp
