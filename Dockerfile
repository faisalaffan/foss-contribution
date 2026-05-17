FROM python:3-alpine AS builder
RUN pip install --no-cache-dir markdown pygments
WORKDIR /src
COPY . .

RUN python3 -c "
import markdown

css = '''
*{box-sizing:border-box;margin:0;padding:0}
body{max-width:900px;margin:0 auto;padding:2rem 1.5rem;font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Helvetica,Arial,sans-serif;line-height:1.7;background:#0d1117;color:#c9d1d9}
a{color:#58a6ff;text-decoration:none}a:hover{text-decoration:underline}
table{border-collapse:collapse;width:100%;margin:1rem 0}
td,th{padding:10px 14px;border:1px solid #30363d;text-align:left;font-size:0.92rem}
th{background:#161b22;font-weight:600}
tr:nth-child(even){background:#161b2240}
code{background:#161b22;padding:2px 6px;border-radius:4px;font-size:0.88em}
pre{background:#161b22;padding:1rem;border-radius:6px;overflow-x:auto;margin:1rem 0;border:1px solid #30363d}
pre code{background:none;padding:0}
h1{font-size:2rem;margin-bottom:0.5rem}
h2{font-size:1.4rem;margin:2rem 0 0.75rem;padding-bottom:0.4rem;border-bottom:1px solid #30363d}
h3{font-size:1.15rem;margin:1.5rem 0 0.5rem}
p{margin:0.75rem 0}
li{margin:0.3rem 0}
ul,ol{padding-left:1.5rem;margin:0.5rem 0}
hr{border:none;border-top:1px solid #30363d;margin:2rem 0}
img{max-width:100%}
.lang-switch{text-align:right;margin-bottom:1.5rem;font-size:0.9rem}
.lang-switch a{padding:0.3rem 0.6rem;border:1px solid #30363d;border-radius:4px;margin-left:0.4rem}
.lang-switch a:hover{background:#1f2937}
'''

def convert(src, dst, label):
    with open(f'/src/{src}') as f:
        md = f.read()
    html = markdown.markdown(md, extensions=['tables','fenced_code','codehilite'])
    body = f'''<!DOCTYPE html>
<html lang=\"en\">
<head><meta charset=\"utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"><meta name=\"color-scheme\" content=\"dark\"><title>FOSS Contributions — Muhammad Faisal Affan</title>
<style>{css}</style></head>
<body>
<div class=\"lang-switch\">{label}</div>
{html}
</body></html>'''
    with open(f'/src/{dst}', 'w') as f:
        f.write(body)

convert('README.md', 'index.html', '<a href=\"/id.html\">🇮🇩 Bahasa Indonesia</a>')
convert('README.id.md', 'id.html', '<a href=\"/\">🇬🇧 English</a>')
print('Done')
"

FROM nginx:alpine
COPY --from=builder /src/index.html /src/id.html /usr/share/nginx/html/
COPY --from=builder /src/contributions /usr/share/nginx/html/contributions
LABEL org.opencontainers.image.source="https://github.com/faisalaffan/foss-contribution"
LABEL org.opencontainers.image.description="FOSS Contribution Portfolio — Muhammad Faisal Affan"
LABEL org.opencontainers.image.licenses="MIT"
