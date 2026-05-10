English | [简体中文](README.md) | [繁體中文](README_ZH_TW.md) | [한국어](README_KO.md)

# opencode-portable

An unofficial portable build of OpenCode, automatically syncing the latest upstream version from [anomalyco/opencode](https://github.com/anomalyco/opencode).
Provides **glibc/musl dual builds + x86_64/arm64 dual architectures**, compatible with all major Linux distributions. Ready to use after extraction, no compilation required.

---

## ✨ Features
- **Auto Sync Upstream**: Check official updates hourly, build and release new versions automatically
- **Dual Build Variants**:
  - `glibc`: Works out-of-the-box on Ubuntu/Debian and mainstream Linux
  - `musl`: Statically linked, compatible with legacy systems like CentOS 7 and NAS devices
- **Multi-arch Support**: Full coverage for x86_64 + arm64
- **Portable Zero-dependency**: Standard directory structure, fully compatible with official CLI
- **Mise Version Management**: One-click install / switch / upgrade

---

## 📦 Installation (Choose One)

### Option 1: Install via mise (Recommended ✅)

1. Install mise
```bash
curl https://mise.run | sh
```

2. Activate mise in shell
```bash
echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
source ~/.bashrc
```

3. Install latest opencode-portable globally
```bash
mise install github:zeronesun/opencode-portable@latest
mise use -g opencode-portable@latest
```

4. Verify installation
```bash
opencode --version
which opencode
```

### Option 2: Manual Install (No Version Manager)

1. Create folder and extract archive
```bash
mkdir -p ~/opencode-portable
tar -xzf opencode-*-portable-linux-*.tar.gz -C ~/opencode-portable
```

2. Add to PATH
```bash
echo 'export PATH="$HOME/opencode-portable/opencode/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

3. Verify installation
```bash
opencode --version
which opencode
```

---

## ✅ Verification Steps (All Methods)
Run the commands below to confirm successful installation:

Check version
```bash
opencode --version
```

Check binary path
```bash
which opencode
```

Launch directly
```bash
opencode
```

---

## ❌ Why Not Symlink to ~/.local/bin
`opencode` is a wrapper script that depends on binaries in the same folder.
Symlinking only the script will cause dependency missing errors. Adding the entire bin directory to PATH is the most reliable way.

---

## ❓ FAQ
### 1. Which variant should I choose?
- Mainstream Linux (Ubuntu/Debian): Use **glibc** build
- Legacy / NAS systems: Use **musl** build

### 2. Musl build errors on Ubuntu?
Musl is incompatible with Ubuntu's native glibc. Regular users should only use the **glibc** version.

### 3. How to upgrade?
- With mise: `mise upgrade opencode-portable`
- Manual: Re-download and replace the latest archive

---

## 📜 License
Built based on [anomalyco/opencode](https://github.com/anomalyco/opencode), licensed under MIT.


## ⭐ Star History

<a href="https://www.star-history.com/?repos=zeronesun%2Fopencode-portable&type=date&legend=top-left">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/chart?repos=zeronesun/opencode-portable&type=date&theme=dark&legend=top-left" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/chart?repos=zeronesun/opencode-portable&type=date&legend=top-left" />
   <img alt="Star History Chart" src="https://api.star-history.com/chart?repos=zeronesun/opencode-portable&type=date&legend=top-left" />
 </picture>
</a>
