# EvoLink API 配置指南

本文档详细介绍如何在 Lobe Chat 中配置和使用 EvoLink API。

## 📌 什么是 EvoLink API？

EvoLink 提供兼容 OpenAI 格式的 AI 模型 API，支持多种主流大语言模型，包括：

- Google Gemini 系列
- OpenAI GPT 系列
- Anthropic Claude 系列
- 以及其他 AI 模型

## 🚀 快速配置

### 步骤 1：获取 EvoLink API 密钥

1. **访问 EvoLink**
   - 打开：https://api.evolink.ai
   - 点击右上角「登录」或「注册」

2. **创建 API 密钥**
   - 登录后进入「API Keys」页面
   - 点击「Create API Key」按钮
   - 输入密钥名称（可选，便于管理）
   - 点击「Create」生成密钥

3. **复制 API 密钥**
   - 密钥格式类似：`evl_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`
   - ⚠️ 只显示一次，请立即复制保存

### 步骤 2：在 Lobe Chat 中配置

#### 方法 A：通过 Vercel 环境变量（推荐）

在 Vercel 项目设置中添加：

```env
OPENAI_API_KEY=evl_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
OPENAI_API_BASE_URL=https://api.evolink.ai/v1
```

#### 方法 B：通过 Lobe Chat 设置界面

1. 打开你的 Lobe Chat 应用
2. 点击左下角设置图标 ⚙️
3. 选择「语言模型」选项卡
4. 在模型服务商列表中找到「OpenAI」
5. 填写以下信息：

   **基础配置：**
   - **API 密钥**：`evl_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`

   **高级配置（点击「高级选项」）：**
   - **自定义 API 地址**：`https://api.evolink.ai/v1`
   - **模型名称**：`gemini-1.5-pro`（或其他模型）

6. 点击「保存」或「验证」按钮

### 步骤 3：验证配置

1. 点击「验证」按钮
2. 如果显示「验证成功」，配置完成
3. 开始新建对话测试

---

## 🎯 支持的模型

### Gemini 系列（推荐）

| 模型名称 | 特点 | 适用场景 |
|---------|------|---------|
| `gemini-1.5-pro` | 高性能，强推理 | 复杂任务、编程、分析 |
| `gemini-1.5-flash` | 快速响应 | 实时对话、简单任务 |
| `gemini-2.0-flash` | 最新版本 | 最新功能测试 |

### GPT 系列

| 模型名称 | 特点 | 适用场景 |
|---------|------|---------|
| `gpt-4o` | 多模态，智能 | 通用任务、图像理解 |
| `gpt-4o-mini` | 轻量快速 | 简单对话、快速响应 |
| `gpt-4-turbo` | 强大能力 | 专业任务、深度分析 |

### Claude 系列

| 模型名称 | 特点 | 适用场景 |
|---------|------|---------|
| `claude-3-5-sonnet` | 平衡性能 | 通用对话、文档分析 |
| `claude-3-5-haiku` | 快速响应 | 轻量任务 |
| `claude-3-opus` | 强大推理 | 复杂问题、编程 |

---

## 💡 使用技巧

### 1. 切换模型

在对话界面：
1. 点击顶部模型选择下拉菜单
2. 选择你想要的模型
3. 新对话将使用该模型

### 2. 设置默认模型

在「语言模型」设置中：
- 在模型名称字段填入默认模型（如 `gemini-1.5-pro`）
- 保存后新建对话将自动使用该模型

### 3. 多模型配置

你可以同时配置多个 API 提供商：
- EvoLink（OpenAI 格式）
- 直接 OpenAI 官方 API
- 其他兼容 OpenAI 的服务

在对话时可以随时切换使用。

---

## 📊 API 使用示例

### cURL 示例

```bash
curl -X POST https://api.evolink.ai/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{
    "model": "gemini-1.5-pro",
    "messages": [
      {
        "role": "user",
        "content": "你好，请介绍一下你自己"
      }
    ]
  }'
```

### JavaScript 示例

```javascript
const response = await fetch('https://api.evolink.ai/v1/chat/completions', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer YOUR_API_KEY'
  },
  body: JSON.stringify({
    model: 'gemini-1.5-pro',
    messages: [
      { role: 'user', content: '你好，请介绍一下你自己' }
    ]
  })
});

const data = await response.json();
console.log(data.choices[0].message.content);
```

---

## 🔧 高级配置

### 自定义参数

在「高级选项」中，你可以配置：

| 参数 | 说明 | 示例 |
|------|------|------|
| `temperature` | 随机性（0-2） | `0.7` |
| `max_tokens` | 最大输出长度 | `2048` |
| `top_p` | 采样阈值 | `0.9` |
| `frequency_penalty` | 频率惩罚 | `0.5` |
| `presence_penalty` | 存在惩罚 | `0.5` |

### 流式响应

Lobe Chat 默认支持流式响应，实时显示 AI 回答内容。

---

## ⚠️ 常见问题

### Q1: API 调用失败，提示 401 错误

**原因：** API 密钥无效或已过期

**解决方法：**
1. 检查 API 密钥是否正确复制
2. 确认密钥未过期
3. 在 EvoLink 后台重新生成密钥

### Q2: 响应很慢

**可能原因：**
- 模型选择（Flash 系列更快）
- 网络延迟
- 服务器负载

**解决方法：**
- 切换到 `gemini-1.5-flash` 或 `gpt-4o-mini`
- 检查网络连接
- 稍后重试

### Q3: 无法选择模型

**解决方法：**
1. 等待 1-2 分钟让 API 初始化
2. 刷新页面
3. 重新配置 API 地址

### Q4: 请求次数达到限制

**解决方法：**
1. 查看 EvoLink 账号使用配额
2. 升级到付费计划
3. 优化请求频率

---

## 💰 费用说明

### 计费方式

EvoLink 按实际使用量计费：

- **输入 Token**：每 1M tokens 的费用
- **输出 Token**：每 1M tokens 的费用
- 不同模型费率不同

### 查看用量

1. 登录 https://api.evolink.ai
2. 进入「Usage」页面
3. 查看 API 调用统计和费用

### 节省费用的技巧

1. **选择合适的模型**
   - 简单任务使用 `flash` 或 `mini` 版本
   - 复杂任务才使用 `pro` 版本

2. **控制上下文长度**
   - 删除不必要的对话历史
   - 减少输入文本长度

3. **启用缓存**
   - 相同问题可以复用缓存结果

---

## 🔗 相关链接

- [EvoLink 官网](https://api.evolink.ai)
- [EvoLink API 文档](https://api.evolink.ai/docs)
- [OpenAI API 参考](https://platform.openai.com/docs/api-reference)
- [Lobe Chat 官方文档](https://lobehub.com/docs)

---

## 📞 技术支持

如果遇到问题：

1. 查看本文档的「常见问题」部分
2. 访问 EvoLink 文档
3. 联系 EvoLink 客服
4. 或者在 Lobe Hub 社区提问
