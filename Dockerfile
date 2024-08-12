FROM rust:slim-bullseye

WORKDIR /usr/src/app

RUN cargo install cargo-watch

COPY Cargo.toml Cargo.lock ./

RUN mkdir src && \
    echo "fn main() {}" > src/main.rs && \
    echo "pub fn run() -> Result<(), std::io::Error> { Ok(()) }" > src/lib.rs

RUN cargo build --release
RUN rm src/main.rs src/lib.rs

COPY . .

RUN cargo build --release

CMD ["cargo", "watch", "-x", "run"]