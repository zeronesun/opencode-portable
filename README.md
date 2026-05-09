# opencode-portable

OpenCode 官方原版 + CJK中文修复 + Musl静态编译适配旧GLIBC 自动同步更新

## ✨ 核心特点

- ✅ **官方最新版本**：每小时自动检测并同步 `anomalyco/opencode` 上游新版本
- ✅ **完美中文支持**：彻底修复#17032号CJK粘贴bug，中文显示、输入、粘贴完全正常
- ✅ **全旧系统兼容**：使用musl静态编译，支持CentOS 7、Ubuntu 20.04、QNAP、Synology等所有低版本GLIBC系统
- ✅ **干净的子进程**：采用Abigail的C预加载库技术，不会污染系统`git`/`ssh`/`curl`等命令
- ✅ **双架构支持**：同时提供x86_64(amd64)和arm64(aarch64)构建
- ✅ **一键安装更新**：原生支持mise包管理器
- ✅ **安全校验**：每个版本自动生成SHA256校验和

## 🚀 安装方法

### 方法一：使用mise（强烈推荐）
```bash
# 安装mise（如果还没有）
curl https://mise.run | sh

# 安装opencode-portable
mise install github:你的用户名/opencode-portable@latest

# 设置为全局默认
mise use -g opencode-portable@latest
```

### 方法二：手动安装
1. 前往 [Releases页面](https://github.com/你的用户名/opencode-portable/releases) 下载对应架构的最新版本
2. 解压tarball：`tar xzf opencode-*-portable-linux-*.tar.gz`
3. 将解压后的`bin`目录添加到你的PATH环境变量
4. 运行`opencode`即可使用

## 📖 使用方法
与官方OpenCode完全一致：
```bash
# 直接启动
opencode

# 查看版本
opencode --version

# 查看帮助
opencode --help
```

## 🆚 版本对比
| 版本 | 中文支持 | 旧GLIBC兼容 | 子进程无污染 | 更新速度 | 多架构支持 |
|------|----------|-------------|--------------|----------|------------|
| 官方原版 | ❌ | ❌ | ✅ | 官方发布 | ✅ |
| pedropombeiro版 | ❌ | ✅ | ⚠️ 部分解决 | 每小时 | ✅ |
| Abigail版 | ✅ | ✅ | ✅ | 1-2周 | ❌ |
| **opencode-portable** | ✅ | ✅ | ✅ | 每小时 | ✅ |

## ⚠️ 免责声明
本项目是第三方开源衍生项目，与OpenCode官方团队(anomalyco)没有任何关联。所有核心功能归官方所有，本项目仅提供：
1. CJK多字节字符显示和输入修复
2. 旧GLIBC系统兼容性适配
3. 自动化构建和发布流程

## 📄 许可证
MIT
