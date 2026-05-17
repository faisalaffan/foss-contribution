FROM python:3-alpine AS builder
RUN pip install --no-cache-dir markdown pygments
WORKDIR /src
COPY . .
RUN python3 scripts/generate-site.py

FROM nginx:alpine
COPY --from=builder /src/index.html /src/id.html /usr/share/nginx/html/
COPY --from=builder /src/contributions /usr/share/nginx/html/contributions
LABEL org.opencontainers.image.source="https://github.com/faisalaffan/foss-contribution"
LABEL org.opencontainers.image.description="FOSS Contribution Portfolio — Muhammad Faisal Affan"
LABEL org.opencontainers.image.licenses="MIT"
