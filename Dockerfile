FROM uniqrn/ruby:v2.6

RUN apt-get update \
  && apt-get install -y --no-install-recommends git ssh \
  && rm -rf /var/lib/apt/lists/*

COPY Gemfile /tmp/Gemfile
WORKDIR /tmp
RUN bundle install
ENV BUNDLE_GEMFILE /tmp/Gemfile
