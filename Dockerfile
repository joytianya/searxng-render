FROM searxng/searxng:latest

# 切换为root用户以安装额外依赖
USER root

# 安装Playwright的依赖（以Ubuntu为例）
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    curl \
    ca-certificates \
    fonts-liberation \
    libgtk-4-1 \
    libgraphene-1.0-0 \
    libgstreamer-gl1.0-0 \
    gstreamer1.0-plugins-bad \
    libavif15 \
    libenchant-2-2 \
    libsecret-1-0 \
    libmanette-0.2-0 \
    libgles2 \
    libnss3 \
    libnspr4 \
    libatk-bridge2.0-0 \
    libcups2 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libpangocairo-1.0-0 \
    libasound2 \
 && rm -rf /var/lib/apt/lists/*

# 安装Python依赖（如果Playwright未安装）
RUN pip install playwright

# 安装Playwright浏览器
RUN playwright install chromium --with-deps

# 切换回原始用户（searxng镜像通常为searxng用户）
USER searxng

COPY settings.yml /etc/searxng/settings.yml

# 镜像启动命令不变（继承自searxng原镜像）
