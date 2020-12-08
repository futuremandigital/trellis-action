  
FROM cytopia/ansible:latest-tools

COPY ./dist/index.js /index.js

# Basic Packages + Sage
RUN apk add --no-cache --virtual .build-deps \
        yarn rsync \
        g++ make autoconf automake libtool nasm \
        libpng-dev libjpeg-turbo-dev \
    && rm -rf /var/cache/apk/* /tmp/*

RUN apk add --no-cache nodejs-current --repository="http://dl-cdn.alpinelinux.org/alpine/edge/community"
RUN node --version

# Basic smoke test
# RUN echo 'node --version' && node --version && \
#     echo 'yarn versions' && yarn versions && \
#     echo 'python --version' && python --version && \
#     echo 'ansible --version' && ansible --version && \
#     echo 'rsync --version' && rsync --version

# Dont use this, we have everything precompiled
#RUN yarn install --production --silent --non-interactive

ENTRYPOINT ["node", "/index.js"]