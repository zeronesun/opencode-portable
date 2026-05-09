# opencode-portable

OpenCode 官方原版 + CJK中文修复 + Musl静态编译适配旧GLIBC 自动同步更新

## 特点

✅ **官方最新版本**：每小时自动检测并同步官方上游新版本
✅ **完美中文支持**：修复#17032号CJK粘贴bug，中文显示和输入正常
✅ **旧系统兼容**：使用musl静态编译，支持CentOS 7、Ubuntu 20.04、QNAP、Synology等所有旧GLIBC系统
✅ **干净的子进程**：使用LD_PRELOAD清理器，不会污染系统命令
✅ **多架构支持**：x86_64和arm64双架构
✅ **一键安装**：支持mise包管理器
✅ **自动校验和**：每个版本都提供SHA256校验和

## 安装

### 方法一：使用mise（推荐）
```bash
# 安装mise（如果还没有）
curl https://mise.run | sh

# 安装opencode-portable
mise install github:你的用户名/opencode-portable@latest

# 设置为全局默认
mise use -g opencode-portable@latest
