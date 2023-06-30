FROM ubuntu:22.04
# RUN apt-get -y update
RUN apt-get -y update && apt-get -y install -f
RUN apt-get -y install curl
RUN apt-get -y install openjdk-17-jdk
RUN apt-get -y install maven
RUN apt-get -y install git
RUN apt-get -y install xvfb

#chrome browser
RUN curl -LO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt-get install -y ./google-chrome-stable_current_amd64.deb
RUN rm google-chrome-stable_current_amd64.deb

#firefox browser
RUN apt-get -y install firefox \
    && ln -fs /opt/firefox/firefox /usr/local/bin/firefox

#edge browser \
RUN apt -y install software-properties-common apt-transport-https \
    && wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" \
    && apt -y install microsoft-edge-stable
