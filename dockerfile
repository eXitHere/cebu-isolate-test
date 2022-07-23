FROM node

RUN apt update
RUN apt install -y libcap-dev
RUN apt install -y asciidoc-base
RUN apt install sudo

COPY . .

WORKDIR /code
RUN g++ code.cpp
# /var/local/lib/isolate/0

WORKDIR /isolate
RUN sudo make
RUN sudo make install
RUN isolate --init

WORKDIR /code
RUN cp a.out /var/local/lib/isolate/0/box

WORKDIR /
RUN npm install 

CMD [ "node", "code.js" ]