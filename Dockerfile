FROM ruby:3.1

# 필수 패키지 설치
RUN apt-get update && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  && rm -rf /var/lib/apt/lists/*

# 작업 디렉토리
WORKDIR /usr/src/app

# Gem 설치용 파일 복사
COPY Gemfile Gemfile.lock ./

# bundler 설치 및 의존성 설치
RUN gem install bundler && bundle install

# 소스 복사
COPY . .

# Jekyll 포트 열기
EXPOSE 4000

# 서버 실행
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]