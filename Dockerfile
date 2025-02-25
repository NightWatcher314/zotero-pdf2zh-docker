# 使用 Python 3.11 作为基础镜像
FROM python:3.11-slim

# 设置工作目录
WORKDIR /app

RUN echo "deb http://mirrors.aliyun.com/debian/ bookworm main non-free non-free-firmware contrib" > /etc/apt/sources.list \
    && echo "deb http://mirrors.aliyun.com/debian/ bookworm-updates main non-free non-free-firmware contrib" >> /etc/apt/sources.list \
    && echo "deb http://mirrors.aliyun.com/debian-security/ bookworm-security main non-free non-free-firmware contrib" >> /etc/apt/sources.list

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
COPY config.json /app/config.json


# 安装 Python 依赖
RUN pip install pdf2zh flask pypdf

# 设置环境变量
ENV PYTHONUNBUFFERED=1

# 创建翻译文件输出目录
RUN mkdir -p /app/translated


# 暴露端口
EXPOSE 8888

# 设置启动命令
CMD ["python", "server.py"] 