# Build stage
FROM swift:5.9-jammy AS build
WORKDIR /app
COPY Package.swift .
COPY Sources ./Sources
COPY Resources ./Resources
RUN swift build -c release

# Run stage
FROM swift:5.9-jammy-slim
RUN useradd --create-home appuser
WORKDIR /app
COPY --from=build /app/.build/release/App .
COPY Resources ./Resources
RUN chown -R appuser:appuser /app
USER appuser
ENV SWIFT_BACKTRACE=enable=yes
EXPOSE 8080
ENTRYPOINT ["./App"]
CMD ["serve", "--env", "production", "--hostname", "0.0.0.0", "--port", "8080"]
