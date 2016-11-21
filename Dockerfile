FROM ubuntu

RUN apt-get update -qq && \
  apt-get install build-essential git bash g++ gcc gcc-multilib libc6-dev linux-libc-dev nodejs npm libssl-dev python -y

RUN mkdir -p /home/qminer

ADD . /home/qminer

WORKDIR /home/qminer

RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN echo 'export PATH="$PATH:/usr/local/bin"' >> ~/.bashrc
RUN echo 'export PATH=$PATH:/home/qminer/node_modules/.bin' >> ~/.bashrc

RUN npm config set registry http://registry.npmjs.org/ && \
  npm install node-pre-gyp -g && \
  node-pre-gyp install --build-from-source && \
  npm install . --build-from-source

