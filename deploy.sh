#!/bin/bash

# ============================================
# Lobe Chat 自动部署脚本
# ============================================

echo "========================================="
echo "  Lobe Chat Vercel 部署助手"
echo "========================================="
echo ""

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 检查必要命令
check_requirements() {
    echo -e "${YELLOW}检查必要工具...${NC}"

    if ! command -v git &> /dev/null; then
        echo -e "${RED}错误: 未找到 git${NC}"
        exit 1
    fi

    if ! command -v node &> /dev/null; then
        echo -e "${RED}错误: 未找到 node${NC}"
        exit 1
    fi

    echo -e "${GREEN}✓ 所有必要工具已安装${NC}"
    echo ""
}

# 初始化 Git 仓库
init_git() {
    if [ -d ".git" ]; then
        echo -e "${YELLOW}Git 仓库已存在${NC}"
    else
        echo "初始化 Git 仓库..."
        git init
        git add .
        git commit -m "Initial commit: Lobe Chat deployment configuration"
        echo -e "${GREEN}✓ Git 仓库已初始化${NC}"
    fi
    echo ""
}

# 生成随机密钥
generate_secret() {
    openssl rand -base64 32 | tr -d '\n'
}

# 生成 JWKS KEY
generate_jwks() {
    # 这里使用简化的 JWKS，实际生产环境建议使用专业工具
    cat << EOF
{
  "keys": [
    {
      "kty": "RSA",
      "kid": "$(openssl rand -hex 8)",
      "use": "sig",
      "alg": "RS256",
      "n": "$(openssl rand -hex 64)",
      "e": "AQAB"
    }
  ]
}
EOF
}

# 生成环境变量文件
generate_env_file() {
    echo "生成环境变量配置..."

    cat > .env.local << EOF
# ============================================
# Lobe Chat 环境变量配置
# ============================================
# ⚠️ 请根据实际情况修改以下配置

# --------------------------------------------
# 应用基础配置
# --------------------------------------------
APP_URL=http://localhost:3000

# --------------------------------------------
# EvoLink API 配置
# --------------------------------------------
# 请访问 https://api.evolink.ai 获取 API 密钥
OPENAI_API_KEY=your_evolink_api_key_here
OPENAI_API_BASE_URL=https://api.evolink.ai/v1

# --------------------------------------------
# 服务端数据库配置（可选）
# --------------------------------------------
# 如需使用服务端数据库，取消以下注释并填写配置

# DATABASE_URL=postgres://username:password@host:port/database
# KEY_VAULTS_SECRET=$(generate_secret)
# AUTH_SECRET=$(generate_secret)
# JWKS_KEY=$(generate_jwks)

# --------------------------------------------
# S3 存储配置（可选）
# --------------------------------------------
# S3_ACCESS_KEY_ID=your_access_key_here
# S3_SECRET_ACCESS_KEY=your_secret_key_here
# S3_BUCKET=your_bucket_name
# S3_ENDPOINT=https://your-bucket.r2.cloudflarestorage.com

# --------------------------------------------
# 高级配置
# --------------------------------------------
# DEFAULT_MODEL=gemini-1.5-pro
# DEBUG=false
EOF

    echo -e "${GREEN}✓ 已生成 .env.local 文件${NC}"
    echo -e "${YELLOW}⚠️  请修改 .env.local 文件中的配置${NC}"
    echo ""
}

# 显示部署步骤
show_deployment_steps() {
    echo "========================================="
    echo "  Vercel 部署步骤"
    echo "========================================="
    echo ""
    echo "1. 将代码推送到 GitHub"
    echo "   git remote add origin https://github.com/你的用户名/你的仓库名.git"
    echo "   git branch -M main"
    echo "   git push -u origin main"
    echo ""
    echo "2. 访问 Vercel 并导入项目"
    echo "   打开: https://vercel.com/new"
    echo "   选择你的 GitHub 仓库"
    echo ""
    echo "3. 配置环境变量"
    echo "   在 Vercel 项目设置中添加环境变量"
    echo "   参考文件: .env.example"
    echo ""
    echo "4. 开始部署"
    echo "   点击 Deploy 按钮"
    echo "   等待 3-5 分钟"
    echo ""
    echo "5. 配置 EvoLink API"
    echo "   参考文件: EVOLINK_API_GUIDE.md"
    echo ""
    echo "========================================="
    echo ""
}

# 主函数
main() {
    check_requirements
    generate_env_file
    init_git
    show_deployment_steps

    echo -e "${GREEN}部署准备完成！${NC}"
    echo ""
    echo "下一步操作："
    echo "1. 编辑 .env.local 文件，填入你的配置"
    echo "2. 将代码推送到 GitHub"
    echo "3. 在 Vercel 中导入项目并部署"
    echo ""
    echo "详细文档："
    echo "- DEPLOYMENT_GUIDE.md - 基础部署指南"
    echo "- ENV_CONFIG_GUIDE.md - 环境变量配置"
    echo "- EVOLINK_API_GUIDE.md - EvoLink API 配置"
    echo "- LOBEHUB_DEPLOYMENT.md - 服务端数据库部署"
    echo ""
}

# 执行主函数
main
