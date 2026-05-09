```markdown
[English](README_EN.md) | [简体中文](README.md) | 繁體中文

# opencode-portable
OpenCode 第三方可攜式建置版本，自動同步 [anomalyco/opencode](https://github.com/anomalyco/opencode) 上游最新版本，提供 **glibc/musl 雙版本 + x86_64/arm64 雙架構**，相容所有主流 Linux 發行版，解壓即可使用，無需編譯環境。

---

## ✨ 功能特色
- **自動同步上游**：每小時自動檢測官方更新，自動建置並發布新版本
- **雙版本適配**：
  - `glibc` 版本：相容 Ubuntu/Debian 等主流系統，解壓即用
  - `musl` 版本：靜態編譯，適用 CentOS 7、NAS 等舊式系統
- **雙架構支援**：x86_64 + arm64 全平台支援
- **零依賴可攜式**：統一目錄結構，指令與官方完全相容
- **支援 mise 版本管理**：一鍵安裝 / 切換 / 更新

---

## 📦 安裝方式（二選一）

### 方式 1：mise 一鍵安裝（推薦 ✅）

1. 安裝 mise 工具
```bash
curl https://mise.run | sh
```

2. 載入 mise 環境
```bash
echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
source ~/.bashrc
```

3. 全域安裝最新版 opencode-portable
```bash
mise install github:ZerosunGitHub/opencode-portable@latest
mise use -g opencode-portable@latest
```

4. 驗證安裝
```bash
opencode --version
which opencode
```

### 方式 2：手動解壓安裝（無額外依賴）

1. 建立目錄並解壓
```bash
mkdir -p ~/opencode-portable
tar -xzf opencode-*-portable-linux-*.tar.gz -C ~/opencode-portable
```

2. 加入環境變數
```bash
echo 'export PATH="$HOME/opencode-portable/opencode/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

3. 驗證安裝
```bash
opencode --version
which opencode
```

---

## ✅ 完整驗證步驟（所有安裝方式通用）
執行以下指令確認安裝成功：

查看版本
```bash
opencode --version
```

查看程式路徑
```bash
which opencode
```

直接啟動
```bash
opencode
```

---

## ❌ 不建議軟連結到 ~/.local/bin 的原因
`opencode` 屬於殼層包裝腳本，必須依賴同目錄下的二進制檔案。
只軟連結腳本會出現**找不到依賴檔案**錯誤，將整個 bin 目錄加入 PATH 是最穩定的做法。

---

## ❓ 常見問題
### 1. 如何選擇版本
- 主流 Linux（Ubuntu/Debian）：請使用 **glibc 版本**
- 舊式系統 / NAS 裝置：請使用 **musl 版本**

### 2. musl 版本在 Ubuntu 執行報錯？
musl 與 Ubuntu 原生程式庫不相容，一般使用者只需使用 **glibc 版本** 即可。

### 3. 如何更新版本？
- 使用 mise：`mise upgrade opencode-portable`
- 手動安裝：重新下載最新壓縮檔替換

---

## 📜 授權條款
本專案基於官方 [anomalyco/opencode](https://github.com/anomalyco/opencode) 建置，遵循 MIT 授權協議
```
