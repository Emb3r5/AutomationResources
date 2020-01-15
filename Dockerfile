# test Dockerfile
FROM kalilinux/kali-linux-docker
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y gpg && apt-get install -y software-properties-common
RUN apt-get update
RUN apt-get install -y git && apt-get install -y apt-transport-https && apt-get update
RUN echo 'we are running some # of cool stuff'
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
RUN mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
RUN wget -q https://packages.microsoft.com/config/debian/9/prod.list
RUN mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
RUN chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
RUN chown root:root /etc/apt/sources.list.d/microsoft-prod.list
RUN mkdir /opt/covenant
WORKDIR /opt/covenant
RUN git clone --recurse-submodules https://github.com/cobbr/Covenant
WORKDIR /opt/covenant/Covenant/Covenant
RUN apt-get update
RUN apt-get install -y dotnet-sdk-2.2
RUN dotnet build
#RUN /opt/covenant/Covenant/Covenant//dotnet run
EXPOSE 80 443 7443

