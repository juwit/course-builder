FROM alpine

# install pre-requisites
RUN apk add bash curl

# install taskfile
RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d

# install asciidoctor
RUN apk add asciidoctor
RUN gem install asciidoctor-pdf rouge

# install node (for decktape)
RUN apk add nodejs npm

# install decktape
RUN npm install -g decktape

# decktape needs chrome in a very specific version
RUN apk add chromium
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# checks installation
RUN task --version
RUN asciidoctor --version
RUN asciidoctor-pdf --version
RUN node --version
RUN decktape version

# create a user to run chrome in a user sandbox
ENV USER=task
RUN adduser -G audio -G video -D task
USER task