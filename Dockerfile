FROM alpine

# install pre-requisites
RUN apk add bash curl

# install taskfile
RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d

# install asciidoctor
RUN apk add asciidoctor
RUN gem install asciidoctor-pdf

# install node (for decktape)
RUN apk add nodejs npm

# install decktape
RUN npm install -g decktape

# decktape needs chrome in a very specific version
ENV PUPPETEER_CHROME_VERSION=127.0.6533.119
RUN npx puppeteer install chrome@${PUPPETEER_CHROME_VERSION}

# checks installation
RUN task --version
RUN asciidoctor --version
RUN asciidoctor-pdf --version
RUN node --version
RUN decktape version
