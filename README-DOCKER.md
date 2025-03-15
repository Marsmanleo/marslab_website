# Mars Lab Docker 使用指南

本文档提供了如何使用Docker容器化运行Mars Lab项目的详细指南。

## 前提条件

- 已安装 [Docker](https://www.docker.com/get-started)
- 已安装 [Docker Compose](https://docs.docker.com/compose/install/)

## 项目结构

本项目包含三个主要服务：

1. **MySQL数据库**：存储应用数据
2. **Laravel后端**：提供API服务
3. **Next.js前端**：提供用户界面

## 快速开始

### 自动设置（推荐）

我们提供了一个自动设置脚本，可以简化整个过程：

```bash
./setup-docker.sh
```

这个脚本会：

- 检查必要的文件和工具
- 准备环境配置
- 构建和启动所有容器

### 手动设置

如果您想手动设置，请按照以下步骤操作：

1. 确保Docker和Docker Compose已安装
2. 准备环境文件
   ```bash
   cp mars-lab/.env.example mars-lab/.env
   ```
3. 修改环境文件中的数据库配置
   ```
   DB_CONNECTION=mysql
   DB_HOST=mysql
   DB_PORT=3306
   DB_DATABASE=mars_lab
   DB_USERNAME=root
   DB_PASSWORD=123456
   ```
4. 构建并启动容器
   ```bash
   docker-compose build
   docker-compose up -d
   ```

## 访问应用

设置完成后，您可以通过以下URL访问各个服务：

- **Laravel API**: [http://localhost:8000](http://localhost:8000)
- **Next.js 前端**: [http://localhost:3000](http://localhost:3000)
- **MySQL 数据库**: localhost:3306 (使用客户端工具连接)

## 常用命令

### 启动服务

```bash
docker-compose up -d
```

### 停止服务

```bash
docker-compose down
```

### 查看容器状态

```bash
docker-compose ps
```

### 查看容器日志

```bash
docker-compose logs -f
```

### 进入容器内部

```bash
docker-compose exec laravel bash  # 进入Laravel容器
docker-compose exec nextjs sh     # 进入Next.js容器
docker-compose exec mysql bash    # 进入MySQL容器
```

## 故障排除

### Laravel服务无法启动

如果Laravel服务无法启动，可能是由于依赖问题。我们提供了一个简单的欢迎页面来替代完整的Laravel应用。您仍然可以通过Next.js前端使用大多数功能。

如果需要调试Laravel：

```bash
docker-compose logs laravel
```

### 数据库连接问题

如果数据库连接出现问题，确保以下几点：

1. MySQL容器已经启动
2. 环境配置中的数据库信息正确
3. 等待足够的时间让MySQL初始化

### Next.js前端无法连接到API

如果Next.js前端无法连接到API，请检查：

1. Laravel服务是否正常运行
2. Next.js的环境变量是否正确配置
3. 网络连接是否正常

## 定制配置

如果需要定制配置，可以修改以下文件：

- `docker-compose.yml`: 修改容器配置
- `mars-lab/Dockerfile`: 修改Laravel容器配置
- `marslab-next/Dockerfile`: 修改Next.js容器配置

修改后需要重新构建容器：

```bash
docker-compose down
docker-compose build
docker-compose up -d
```
