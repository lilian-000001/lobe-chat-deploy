# Vercel 一键部署配置

## 📋 部署前准备

1. 准备一个 GitHub 仓库
2. 注册 [Vercel](https://vercel.com) 账号
3. 准备 EvoLink API 密钥（从 https://api.evolink.ai 获取）

## 🚀 一键部署步骤

### 方法一：通过 GitHub 仓库部署

1. **创建 GitHub 仓库**
   ```bash
   # 初始化 git 仓库
   git init
   git add .
   git commit -m "Initial commit"
   
   # 推送到 GitHub（替换为你的仓库地址）
   git remote add origin https://github.com/你的用户名/你的仓库名.git
   git branch -M main
   git push -u origin main
   ```

2. **访问 Lobe Chat GitHub**
   - 打开 https://github.com/lobehub/lobe-chat
   - 点击绿色的 "Deploy" 或 "Code" 按钮
   - 选择 "Deploy with Vercel"

3. **授权 Vercel**
   - 点击 "Deploy" 按钮授权 Vercel 访问你的 GitHub
   - 选择导入 Lobe Chat 项目

4. **配置环境变量**
   在 Vercel 项目设置中添加以下环境变量：
   
   ```env
   # 应用基础配置
   APP_URL=https://your-app.vercel.app
   ```

5. **部署项目**
   - 点击 "Deploy" 按钮开始部署
   - 等待 3-5 分钟，部署完成
   - 获取你的专属 URL（如 your-app.vercel.app）

### 方法二：直接从 Vercel 导入

1. 登录 [Vercel Dashboard](https://vercel.com/dashboard)
2. 点击 "Add New" → "Project"
3. 在输入框中粘贴：`https://github.com/lobehub/lobe-chat`
4. 点击 "Import"
5. 配置环境变量（同上）
6. 点击 "Deploy"

## ⚙️ 配置 EvoLink API

部署完成后，打开你的 Lobe Chat 应用：

### 1. 进入设置
- 点击左下角的设置图标 ⚙️
- 选择「语言模型」选项卡

### 2. 配置 OpenAI 兼容接口（EvoLink）
在模型服务商列表中，找到「OpenAI」（因为 EvoLink 接口兼容 OpenAI 格式）

**基础配置：**
- **API 密钥**：粘贴你的 EvoLink API 密钥
  ```
  获取方式：登录 https://api.evolink.ai → API Keys → 复制密钥
  ```

**高级配置（点击「高级选项」）：**
- **自定义 API 地址**：`https://api.evolink.ai/v1`
- **模型名称**：`gemini-1.5-pro` 或其他可用模型

### 3. 保存配置
点击「保存」或「验证」按钮，如果提示成功，就配置完成了！

## 🎯 开始使用

1. 点击「新建对话」
2. 在顶部模型选择下拉菜单中，选择你刚才配置的模型
3. 开始愉快地聊天吧！

## 📝 可用模型示例

EvoLink 支持的常见模型：
- `gemini-1.5-pro`
- `gemini-1.5-flash`
- `gpt-4o`
- `gpt-4o-mini`
- `claude-3-5-sonnet`

## ⚠️ 注意事项

1. **API 密钥安全**
   - 不要将 API 密钥提交到 GitHub
   - 只在 Vercel 环境变量中配置
   - 定期更换密钥

2. **域名配置（可选）**
   - 在 Vercel 项目设置 → Domains 添加自定义域名
   - 记得更新 APP_URL 环境变量

3. **部署限制**
   - 免费版 Vercel 有每月 100GB 带宽限制
   - 部署超时时间为 60 秒
   - 服务器函数执行时间最多 10 秒

## 🔧 故障排除

### 问题：部署失败
- 检查 Vercel 部署日志
- 确保所有依赖正确安装
- 清除缓存后重新部署

### 问题：API 调用失败
- 确认 API 密钥有效
- 检查 API 地址是否正确：`https://api.evolink.ai/v1`
- 查看 Vercel 函数日志

### 问题：模型无法选择
- 等待 EvoLink API 初始化（1-2 分钟）
- 刷新页面重新加载模型列表
- 检查网络连接

## 📚 相关链接

- [Lobe Chat 官方文档](https://lobehub.com/docs)
- [Vercel 部署文档](https://vercel.com/docs/deployments)
- [EvoLink API 文档](https://api.evolink.ai/docs)

## 💡 进阶配置

如需更多功能（如：
- 数据库集成（Vercel Postgres）
- 用户身份验证
- 文件存储（S3/R2）
- 多语言支持）

请参考 `LOBEHUB_DEPLOYMENT.md` 文档进行配置。
