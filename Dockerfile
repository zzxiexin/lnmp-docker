# 第一阶段：构建前端代码

# 基于 Node 镜像构建应用
FROM node:14 AS builder

# 安装 Git
RUN apt-get update && apt-get install -y git

# 设置工作目录并拉取代码
ARG git_url
WORKDIR /app
RUN git clone ${git_url} .

# 安装依赖并构建项目
RUN npm i pnpm -g 
RUN pnpm install && npm run build


# 第二阶段：设置 Nginx 服务器

# 基于 Nginx 镜像构建容器
FROM nginx:latest

# 将构建好的前端代码复制到容器中
COPY --from=builder /app/dist /usr/share/nginx/html

# 复制自定义 nginx.conf 文件到容器中（如果需要）
# COPY nginx.conf /etc/nginx/nginx.conf

# 暴露容器的80端口，允许外部访问
EXPOSE 80

# 启动 Nginx 服务
CMD ["nginx", "-g", "daemon off;"]