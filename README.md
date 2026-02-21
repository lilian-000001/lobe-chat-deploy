# Lobe Chat Vercel 部署项目

本项目提供了完整的 Lobe Chat 在 Vercel 上部署所需的配置文件和文档。

## 📚 文档说明

- **[DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md)** - Vercel 一键部署指南（推荐新手）
- **[ENV_CONFIG_GUIDE.md](./ENV_CONFIG_GUIDE.md)** - 环境变量配置详细说明
- **[EVOLINK_API_GUIDE.md](./EVOLINK_API_GUIDE.md)** - EvoLink API 配置指南
- **[LOBEHUB_DEPLOYMENT.md](./LOBEHUB_DEPLOYMENT.md)** - 服务端数据库部署（高级用户）

## 🚀 快速开始

### 方法一：使用部署脚本（推荐）

```bash
# 克隆或下载本项目
git clone <your-repo-url>
cd <your-repo>

# 运行部署脚本（Linux/Mac）
chmod +x deploy.sh
./deploy.sh

# Windows 用户
# 手动执行脚本中的命令，或参考 DEPLOYMENT_GUIDE.md
```

### 方法二：手动部署

1. **阅读部署指南**
   ```
   打开 DEPLOYMENT_GUIDE.md
   ```

2. **配置环境变量**
   - 复制 `.env.example` 为 `.env.local`
   - 填入你的配置
   - 参考 `ENV_CONFIG_GUIDE.md`

3. **推送到 GitHub**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/你的用户名/你的仓库名.git
   git branch -M main
   git push -u origin main
   ```

4. **在 Vercel 部署**
   - 访问 https://vercel.com/new
   - 导入你的 GitHub 仓库
   - 配置环境变量
   - 点击 Deploy

## 📋 必需环境变量

在 Vercel 项目设置中至少需要配置：

```env
APP_URL=https://your-app.vercel.app
OPENAI_API_KEY=your_evolink_api_key
OPENAI_API_BASE_URL=https://api.evolink.ai/v1
```

**获取 API 密钥：**
- 访问 https://api.evolink.ai
- 注册/登录账号
- 创建 API Key

## 🎯 部署流程

```
1. 获取 EvoLink API 密钥
   ↓
2. 配置环境变量
   ↓
3. 推送代码到 GitHub
   ↓
4. 在 Vercel 导入项目
   ↓
5. 配置 Vercel 环境变量
   ↓
6. 部署并验证
   ↓
7. 在 Lobe Chat 中配置 EvoLink API
```

## 📁 项目结构

```
.
├── README.md                  # 本文件
├── deploy.sh                  # 部署脚本
├── .env.example              # 环境变量示例
├── vercel.json               # Vercel 配置
├── package.json              # 项目配置
├── DEPLOYMENT_GUIDE.md       # 基础部署指南
├── ENV_CONFIG_GUIDE.md       # 环境变量配置
├── EVOLINK_API_GUIDE.md      # EvoLink API 配置
└── LOBEHUB_DEPLOYMENT.md     # 服务端数据库部署
```

## ⚙️ 配置文件说明

### `.env.example`
环境变量模板，不要直接使用，复制后修改为 `.env.local`

### `vercel.json`
Vercel 部署配置，定义了：
- 构建命令
- 输出目录
- 部署区域

### `package.json`
项目依赖和脚本配置

## 🔧 高级配置

如需使用以下功能，请参考 `LOBEHUB_DEPLOYMENT.md`：

- ✅ 用户注册登录
- ✅ 数据持久化
- ✅ 文件存储（S3/R2）
- ✅ SSO 身份验证

## ❓ 常见问题

### Q: 部署后无法访问？
A: 检查 Vercel 部署日志，确认环境变量已正确配置

### Q: API 调用失败？
A:
1. 验证 API 密钥是否有效
2. 确认 `OPENAI_API_BASE_URL` 为 `https://api.evolink.ai/v1`
3. 查看 Vercel 函数日志

### Q: 如何配置自定义域名？
A: 在 Vercel 项目设置 → Domains 添加自定义域名

### Q: 如何查看使用情况？
A: 访问 https://api.evolink.ai 查看 API 使用统计

## 📞 技术支持

- [Lobe Chat 官方文档](https://lobehub.com/docs)
- [EvoLink API 文档](https://api.evolink.ai/docs)
- [Vercel 部署文档](https://vercel.com/docs)

## 📄 许可证

本项目配置文件遵循 MIT 许可证。

---

**祝部署顺利！🎉**
