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

# checks installation
RUN task --version
RUN asciidoctor --version
RUN asciidoctor-pdf --version
RUN node --version
RUN decktape version
