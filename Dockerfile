FROM ruby:2.6.5-buster AS builder
COPY Gemfile /tmp/Gemfile
WORKDIR /tmp
RUN bundle install

FROM uniqrn/ruby:v2.6

RUN apt-get update \
  && apt-get install -y --no-install-recommends git ssh rsync \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /root/.bundle /root/.bundle
COPY --from=builder /tmp/Gemfile.lock /tmp/Gemfile.lock
COPY Gemfile /tmp/Gemfile

WORKDIR /opt
ENV BUNDLE_GEMFILE /tmp/Gemfile
