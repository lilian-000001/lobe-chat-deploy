# 环境变量配置指南

本文档详细说明 Lobe Chat 部署时所需的环境变量配置。

## 📦 必需环境变量

### 基础配置

```env
APP_URL=https://your-app.vercel.app
```

**说明：** 应用的完整 URL，部署后替换为你的实际 Vercel 域名

**获取方式：**
1. 部署完成后，Vercel 会提供 URL（如 `https://your-project.vercel.app`）
2. 在 Vercel 项目设置中查看

### EvoLink API 配置

```env
OPENAI_API_KEY=your_evolink_api_key_here
OPENAI_API_BASE_URL=https://api.evolink.ai/v1
```

**说明：**
- `OPENAI_API_KEY`：你的 EvoLink API 密钥
- `OPENAI_API_BASE_URL`：EvoLink API 地址（兼容 OpenAI 格式）

**获取 API 密钥：**
1. 访问 https://api.evolink.ai
2. 登录或注册账号
3. 进入「API Keys」页面
4. 点击「Create API Key」
5. 复制生成的密钥

**⚠️ 安全提示：**
- 不要将 API 密钥提交到代码仓库
- 只在 Vercel 环境变量中配置
- 定期更换密钥

---

## 🎯 在 Vercel 中配置环境变量

### 步骤 1：打开项目设置
1. 登录 [Vercel Dashboard](https://vercel.com/dashboard)
2. 选择你的 Lobe Chat 项目
3. 点击「Settings」标签

### 步骤 2：添加环境变量
1. 左侧菜单选择「Environment Variables」
2. 点击「Add New」添加每个环境变量

**必需变量：**
| 变量名 | 值 | 示例 |
|--------|-----|------|
| `APP_URL` | 你的 Vercel 域名 | `https://my-chat.vercel.app` |
| `OPENAI_API_KEY` | EvoLink API 密钥 | `evl_xxxxxxxxxxxxx` |
| `OPENAI_API_BASE_URL` | API 地址 | `https://api.evolink.ai/v1` |

### 步骤 3：选择环境
- **Production**：生产环境（正式部署）
- **Preview**：预览环境（测试部署）
- **Development**：开发环境

**建议：**
- 所有变量都添加到「All Environments」
- 这样所有环境都会使用相同的配置

### 步骤 4：重新部署
添加环境变量后，需要重新部署：
1. 进入「Deployments」标签
2. 找到最新的部署
3. 点击「Redeploy」
4. 等待部署完成

---

## 🔧 本地开发配置

如果你想在本地运行 Lobe Chat：

### 1. 克隆项目
```bash
git clone https://github.com/lobehub/lobe-chat.git
cd lobe-chat
```

### 2. 安装依赖
```bash
npm install
```

### 3. 配置环境变量
```bash
# 复制示例文件
cp .env.example .env.local

# 编辑 .env.local 文件，填入你的配置
# 至少需要配置：
# - APP_URL=http://localhost:3000
# - OPENAI_API_KEY=你的_evolink_api_key
# - OPENAI_API_BASE_URL=https://api.evolink.ai/v1
```

### 4. 启动开发服务器
```bash
npm run dev
```

访问 http://localhost:3000

---

## 🗄️ 可选：服务端数据库配置

如果需要使用服务端数据库（用户数据持久化），需要额外配置：

### 数据库环境变量

```env
# Postgres 数据库
DATABASE_URL=postgres://username:password@host:port/database

# 密钥加密
KEY_VAULTS_SECRET=your_secret_key_here

# 身份验证
AUTH_SECRET=your_auth_secret_here
JWKS_KEY={"keys":[...]}
```

**注意：** 这些变量需要全部配置后再部署，否则可能导致数据库迁移失败

### S3 存储配置（文件存储）

```env
S3_ACCESS_KEY_ID=your_access_key
S3_SECRET_ACCESS_KEY=your_secret
S3_BUCKET=your_bucket_name
S3_ENDPOINT=https://your-bucket.r2.cloudflarestorage.com
```

**详细说明请参考：** `LOBEHUB_DEPLOYMENT.md`

---

## 🧪 验证配置

部署完成后，验证环境变量是否生效：

1. 访问你的应用 URL
2. 点击左下角设置图标 ⚙️
3. 选择「语言模型」选项卡
4. 检查 OpenAI 配置是否正确
5. 点击「验证」按钮测试 API 连接

**如果验证成功，说明配置正确！**

---

## ⚠️ 常见问题

### Q1: 部署后 API 调用失败？

**解决方法：**
1. 检查 Vercel 环境变量是否已保存
2. 确认 API 密钥是否有效
3. 检查 `OPENAI_API_BASE_URL` 是否为 `https://api.evolink.ai/v1`
4. 查看 Vercel 函数日志

### Q2: 环境变量修改后未生效？

**解决方法：**
1. 环境变量修改后需要重新部署
2. 在 Vercel Dashboard 点击「Redeploy」
3. 等待部署完成后再测试

### Q3: 如何生成 AUTH_SECRET 和 KEY_VAULTS_SECRET？

**生成命令：**
```bash
# 生成 AUTH_SECRET
openssl rand -base64 32

# 生成 KEY_VAULTS_SECRET
openssl rand -base64 32
```

### Q4: 如何查看当前配置的环境变量？

**在代码中检查：**
```javascript
console.log(process.env.APP_URL);
console.log(process.env.OPENAI_API_KEY);
```

**在 Vercel Dashboard 查看：**
Settings → Environment Variables

---

## 📚 参考链接

- [Vercel 环境变量文档](https://vercel.com/docs/projects/environment-variables)
- [EvoLink API 文档](https://api.evolink.ai/docs)
- [Lobe Chat 配置文档](https://lobehub.com/docs/configuration)
