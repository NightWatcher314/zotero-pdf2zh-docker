# 使用 Python 3.11 作为基础镜像
FROM python:3.11-slim

# 设置工作目录
WORKDIR /app

# 安装系统依赖和中文字体
RUN apt-get update && apt-get install -y \
    git \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# 克隆项目代码
# RUN git clone https://github.com/guaguastandup/zotero-pdf2zh.git .

COPY server.py /app/server.py

COPY LXGWWenKai-Regular.ttf /app/fonts/LXGWWenKai-Regular.ttf

# 安装 Python 依赖
RUN pip install pdf2zh flask pypdf

# 设置环境变量
ENV PYTHONUNBUFFERED=1

ENV DEEPLX_ENDPOINT=http://localhost:1188/translate/
ENV OLLAMA_HOST=http://127.0.0.1:11434
ENV OLLAMA_MODEL=gemma2
ENV OPENAI_BASE_URL=https://api.openai.com/v1
ENV OPENAI_API_KEY=sk-proj-01234567890123456789012345678901
ENV OPENAI_MODEL=gpt-4o

# 创建翻译文件输出目录
RUN mkdir -p /app/translated
COPY config.json /app/config.json


# 设置卷映射（仅用于字体和翻译输出目录）
VOLUME ["/app/fonts"]
VOLUME ["/app/translated"]

# 暴露端口
EXPOSE 8888

# 设置启动命令
CMD ["python", "server.py"] 