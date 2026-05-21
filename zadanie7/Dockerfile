# Build stage
FROM swift:5.9-jammy as build
WORKDIR /app
COPY Package.swift .
COPY Sources ./Sources
COPY Resources ./Resources
RUN swift build -c release

# Run stage
FROM swift:5.9-jammy-slim
WORKDIR /app
COPY --from=build /app/.build/release/App .
COPY Resources ./Resources
ENV SWIFT_BACKTRACE=enable=yes
EXPOSE 8080
ENTRYPOINT ["./App"]
CMD ["serve", "--env", "production", "--hostname", "0.0.0.0", "--port", "8080"]
