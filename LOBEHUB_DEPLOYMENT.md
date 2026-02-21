# LobeHub 服务端数据库部署指南

> ⚠️ **重要提示：** 本文档适用于需要服务端数据库（用户数据持久化）的场景。如果你只是需要基础的 AI 聊天功能，请参考 `DEPLOYMENT_GUIDE.md`。

---

## 📋 部署前必读

### ⚠️ 重要警告

1. **数据迁移**
   - 导出所有数据后，部署服务端数据库
   - 原有用户数据无法自动迁移
   - 必须提前备份，之后手动导入

2. **环境变量**
   - 配置数据库环境变量时，必须**全部填入后再部署**
   - 否则可能遭遇数据库迁移问题
   - 建议一次性配置所有必需变量

3. **部署顺序**
   - 先配置环境变量
   - 再提交代码
   - 最后重新部署

---

## 🗄️ 一、配置数据库

### 准备 Postgres 数据库实例

你需要一个 Postgres 数据库，可以选择以下两种方式：

#### A. 使用 Serverless Postgres（推荐）

**推荐服务商：**
- [Vercel Postgres](https://vercel.com/docs/storage/vercel-postgres)
- [Neon](https://neon.tech)
- [Supabase](https://supabase.com)

**获取连接 URL：**
1. 在服务提供商后台创建数据库
2. 获取连接 URL，格式如下：
   ```
   postgres://username:password@host:port/database
   ```

#### B. 使用 Docker 自部署

```bash
# 运行 Postgres 容器
docker run --name postgres \
  -e POSTGRES_USER=your_user \
  -e POSTGRES_PASSWORD=your_password \
  -e POSTGRES_DB=lobe_chat \
  -p 5432:5432 \
  -d postgres:16

# 连接 URL
postgres://your_user:your_password@localhost:5432/lobe_chat
```

---

### 在 Vercel 中添加数据库环境变量

#### Serverless Postgres 配置

在 Vercel 项目设置 → Environment Variables 中添加：

```env
# Serverless Postgres 连接 URL
DATABASE_URL=postgres://username:password@host:port/database
```

**示例：**
```env
DATABASE_URL=postgres://user:pass@db.example.com:5432/lobe_chat
```

#### Node Postgres 配置（如果使用 Node Postgres）

```env
# Node Postgres 连接 URL（不同格式）
POSTGRES_PRISMA_URL=postgres://username:password@host:port/database
```

---

### 添加 KEY_VAULTS_SECRET

该变量用于加密用户存储的 API Key 等敏感信息。

#### 生成密钥

**方法 1：使用 openssl（推荐）**
```bash
openssl rand -base64 32
```

**方法 2：使用 Node.js**
```bash
node -e "console.log(require('crypto').randomBytes(32).toString('base64'))"
```

生成的密钥示例：
```
jgwsK28dspyVQoIf8/M3IIHl1h6LYYceSYNXeLpy6uk=
```

#### 添加到 Vercel

```env
KEY_VAULTS_SECRET=jgwsK28dspyVQoIf8/M3IIHl1h6LYYceSYNXeLpy6uk=
```

---

### 添加 APP_URL

指定应用的 URL 地址。

```env
APP_URL=https://your-app.vercel.app
```

**注意：** 替换为你的实际 Vercel 域名

---

## 🔐 二、配置身份验证服务

服务端数据库需要搭配用户身份验证服务使用。

### 生成 AUTH_SECRET

#### 生成密钥

```bash
openssl rand -base64 32
```

示例：
```
jgwsK28dspyVQoIf8/M3IIHl1h6LYYceSYNXeLpy6uk=
```

#### 添加到 Vercel

```env
AUTH_SECRET=jgwsK28dspyVQoIf8/M3IIHl1h6LYYceSYNXeLpy6uk=
```

---

### 生成 JWKS_KEY

用于签名和验证 JWT。

#### 生成 JWKS_KEY

**使用在线工具：**
- 访问 https://mkjwk.org
- 配置参数后生成 JWKS

**或使用命令行：**
```bash
# 需要安装 mkjwk-cli
npm install -g mkjwk-cli
mkjwk
```

生成的格式示例：
```json
{
  "keys": [
    {
      "kty": "RSA",
      "kid": "xxx",
      "use": "sig",
      "alg": "RS256",
      "n": "xxx",
      "e": "AQAB"
    }
  ]
}
```

#### 添加到 Vercel

```env
JWKS_KEY={"keys":[{"kty":"RSA","kid":"xxx","use":"sig","alg":"RS256","n":"xxx","e":"AQAB"}]}
```

---

### 完整身份验证环境变量

```env
AUTH_SECRET=jgwsK28dspyVQoIf8/M3IIHl1h6LYYceSYNXeLpy6uk=
JWKS_KEY={"keys":[...]}
```

**功能说明：**
- ✅ 邮箱密码注册登录
- ✅ SSO 登录（需额外配置）
- ✅ 魔法链接登录（需额外配置）
- ✅ 邮箱验证（需额外配置）

---

## 📦 三、配置 S3 存储服务

S3 指的是兼容 S3 API 的对象存储系统，常见服务商包括：
- AWS S3
- Cloudflare R2（推荐）
- 阿里云 OSS
- 腾讯云 COS

---

### 配置并获取 S3 存储桶

#### 使用 Cloudflare R2（推荐）

1. **创建存储桶**
   - 登录 Cloudflare Dashboard
   - 选择「R2」服务
   - 点击「创建存储桶」
   - 输入存储桶名称（如 `LobeHub`）
   - 点击「创建」

2. **获取存储桶信息**
   - 进入存储桶设置
   - 查看存储桶配置信息

---

#### 获取 S3 环境变量

从存储桶配置中提取以下信息：

```env
# 存储桶名称
S3_BUCKET=LobeHub

# 存储桶端点（必须删除路径）
S3_ENDPOINT=https://0b33a03b5c993fd2f453379dc36558e5.r2.cloudflarestorage.com
```

**⚠️ 重要：**
- `S3_ENDPOINT` 必须删除路径
- 只保留域名部分
- 确保 URL 包含 `https://`

---

### 获取 S3 密钥

#### 在 Cloudflare R2 中创建 API Token

1. 进入 R2 → 你的账户
2. 找到「R2 API Tokens」
3. 点击「创建 API Token」
4. 配置权限：
   - 选择「对象读与写」
   - 设置 TTL（或不过期）
5. 点击「创建」

6. 复制生成的 API Token

**获得的环境变量：**
```env
S3_ACCESS_KEY_ID=9998d6757e276cf9f1edbd325b7083a6
S3_SECRET_ACCESS_KEY=55af75d8eb6b99f189f6a35f855336ea62cd9c4751a5cf4337c53c1d3f497ac2
```

---

### 完整 S3 环境变量

```env
# S3 密钥
S3_ACCESS_KEY_ID=9998d6757e276cf9f1edbd325b7083a6
S3_SECRET_ACCESS_KEY=55af75d8eb6b99f189f6a35f855336ea62cd9c4751a5cf4337c53c1d3f497ac2

# 存储桶配置
S3_BUCKET=LobeHub
S3_ENDPOINT=https://0b33a03b5c993fd2f453379dc36558e5.r2.cloudflarestorage.com

# 可选：桶区域（一般不需要）
# S3_REGION=us-west-1
```

---

### 配置跨域（CORS）

由于 S3 是独立域名，需要配置跨域访问。

#### 在 Cloudflare R2 中配置 CORS

1. 进入存储桶设置
2. 找到「CORS Policy」
3. 添加 CORS 规则：

```json
[
  {
    "AllowedOrigins": [
      "https://your-app.vercel.app"
    ],
    "AllowedMethods": [
      "GET",
      "PUT",
      "HEAD",
      "POST",
      "DELETE"
    ],
    "AllowedHeaders": [
      "*"
    ],
    "MaxAgeSeconds": 86400
  }
]
```

4. 点击「保存」

**注意：** 将 `https://your-app.vercel.app` 替换为你的实际域名

---

## 📝 四、完整环境变量一览

将以下所有变量一次性添加到 Vercel 环境变量：

```env
# ============================================
# 应用基础配置
# ============================================
APP_URL=https://your-app.vercel.app

# ============================================
# 数据库配置
# ============================================
# Serverless Postgres
DATABASE_URL=postgres://username:password@host:port/database

# 密钥加密
KEY_VAULTS_SECRET=jgwsK28dspyVQoIf8/M3IIHl1h6LYYceSYNXeLpy6uk=

# ============================================
# 身份验证
# ============================================
AUTH_SECRET=jgwsK28dspyVQoIf8/M3IIHl1h6LYYceSYNXeLpy6uk=
JWKS_KEY={"keys":[{"kty":"RSA","kid":"xxx","use":"sig","alg":"RS256","n":"xxx","e":"AQAB"}]}

# ============================================
# S3 存储配置
# ============================================
S3_ACCESS_KEY_ID=9998d6757e276cf9f1edbd325b7083a6
S3_SECRET_ACCESS_KEY=55af75d8eb6b99f189f6a35f855336ea62cd9c4751a5cf4337c53c1d3f497ac2
S3_BUCKET=LobeHub
S3_ENDPOINT=https://0b33a03b5c993fd2f453379dc36558e5.r2.cloudflarestorage.com

# ============================================
# EvoLink API（可选，用于模型调用）
# ============================================
OPENAI_API_KEY=your_evolink_api_key
OPENAI_API_BASE_URL=https://api.evolink.ai/v1
```

---

## 🚀 五、部署并验证

### 重新部署

配置完所有环境变量后：

1. **提交代码**
   ```bash
   git add .
   git commit -m "Configure database environment variables"
   git push
   ```

2. **在 Vercel 中触发部署**
   - 进入 Vercel 项目 → Deployments
   - 点击「Redeploy」
   - 等待部署完成（3-5 分钟）

---

### 验证部署

1. **访问应用**
   - 打开你的应用 URL
   - 例如：https://your-app.vercel.app

2. **检查数据库连接**
   - 点击左上角「登录」
   - 如果显示登录弹窗，说明配置成功

3. **注册用户**
   - 点击「注册」
   - 填写邮箱和密码
   - 验证注册功能

4. **测试存储**
   - 上传头像或文件
   - 检查 S3 存储是否正常

---

## ⚠️ 六、常见问题

### Q1: 数据库迁移失败

**原因：** 环境变量未完全配置

**解决方法：**
1. 确认所有必需变量都已添加
2. 清除 Vercel 缓存
3. 重新部署

### Q2: 登录功能不工作

**原因：** 身份验证配置错误

**解决方法：**
1. 检查 `AUTH_SECRET` 和 `JWKS_KEY` 格式
2. 确认数据库连接正常
3. 查看 Vercel 函数日志

### Q3: 文件上传失败

**原因：** S3 配置或 CORS 问题

**解决方法：**
1. 检查 S3 端点是否正确（无路径）
2. 确认 CORS 规则配置正确
3. 验证 S3 密钥权限

### Q4: 无法创建用户

**原因：** 数据库权限问题

**解决方法：**
1. 确认数据库用户有 CREATE 权限
2. 检查数据库 URL 格式
3. 验证数据库连接

---

## 🔗 七、相关链接

- [Vercel Postgres 文档](https://vercel.com/docs/storage/vercel-postgres)
- [Cloudflare R2 文档](https://developers.cloudflare.com/r2/)
- [Lobe Hub 官方文档](https://lobehub.com/docs)
- [Better Auth 文档](https://www.better-auth.com/docs)

---

## 📞 技术支持

遇到问题时：

1. 查看 Vercel 部署日志
2. 检查环境变量配置
3. 参考本文档「常见问题」部分
4. 在 Lobe Hub 社区提问

---

## 📌 总结

部署 LobeHub 服务端数据库需要：

1. ✅ 配置 Postgres 数据库
2. ✅ 配置身份验证服务
3. ✅ 配置 S3 存储
4. ✅ 所有环境变量一次性配置
5. ✅ 重新部署并验证

**部署时间：** 约 15-20 分钟（包括准备时间）

祝你部署顺利！🎉
