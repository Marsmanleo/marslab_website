#!/bin/bash

echo "===== Mars Lab Docker 自动设置脚本 ====="
echo "正在检查必要文件..."

# 检查Docker是否已安装
if ! command -v docker &> /dev/null; then
    echo "错误: Docker未安装，请先安装Docker"
    exit 1
fi

# 检查Docker Compose是否已安装
if ! command -v docker-compose &> /dev/null; then
    echo "错误: Docker Compose未安装，请先安装Docker Compose"
    exit 1
fi

# 确保index.php.docker存在
if [ ! -f mars-lab/public/index.php.docker ]; then
    echo "错误: mars-lab/public/index.php.docker 文件不存在"
    exit 1
fi

# 创建Laravel临时环境文件
echo "正在准备Laravel环境文件..."
cat > mars-lab/.env << EOL
APP_NAME=MarsLab
APP_ENV=production
APP_KEY=base64:fHwrBH2rVKUr+swuvEIdFugsqwv8IHLlVAVFM8LKqqc=
APP_DEBUG=true
APP_URL=http://localhost:8000

DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=mars_lab
DB_USERNAME=root
DB_PASSWORD=123456

CACHE_DRIVER=file
SESSION_DRIVER=file
QUEUE_DRIVER=sync

JWT_SECRET=your-secure-random-secret
JWT_TTL=1440
EOL

# 停止并删除现有容器
echo "停止并删除现有容器..."
docker-compose down

# 构建和启动容器
echo "构建和启动容器..."
docker-compose build
docker-compose up -d

# 等待容器启动
echo "等待容器启动..."
sleep 10

# 显示容器状态
echo "容器状态:"
docker-compose ps

echo ""
echo "===== 设置完成 ====="
echo "Laravel API: http://localhost:8000"
echo "Next.js 前端: http://localhost:3000"
echo "MySQL 数据库: localhost:3306"
echo ""
echo "要查看容器日志，请运行:"
echo "docker-compose logs -f" 