FROM rust:1.85.0 as builder

WORKDIR /usr/src/zt-tcp-relay
COPY . .
RUN cargo build --release



FROM debian:bookworm-slim

COPY --from=builder /usr/src/zt-tcp-relay/target/release/zt-tcp-relay /app/zt-tcp-relay
RUN chmod +x /app/zt-tcp-relay
WORKDIR /app/

ENV RUST_LOG=info

CMD ["/app/zt-tcp-relay", "--listen", "0.0.0.0:443", "--max-conn", "8"]
