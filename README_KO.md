[English](README_EN.md) | [简体中文](README.md) | [繁體中文](README_ZH_TW.md) | 한국어

# opencode-portable
OpenCode의 타사 이식 가능한 빌드 버전으로, [anomalyco/opencode](https://github.com/anomalyco/opencode) 업스트림 최신 버전을 자동으로 동기화합니다.  
**glibc/musl 이중 빌드 + x86_64/arm64 이중 아키텍처**를 제공하며, 모든 주요 Linux 배포판과 호환됩니다. 압축 해제 후 즉시 사용 가능하며, 컴파일이 필요하지 않습니다.

---

## ✨ 기능 특징
- **업스트림 자동 동기화**: 매시간 공식 업데이트를 확인하고, 자동으로 빌드 및 새 버전을 출시합니다.
- **이중 빌드 변형**:
  - `glibc`: Ubuntu/Debian 및 주요 Linux에서 즉시 사용 가능
  - `musl`: 정적 링크로, CentOS 7 및 NAS 장치와 같은 레거시 시스템과 호환됩니다.
- **멀티 아키텍처 지원**: x86_64 + arm64 플랫폼을 완전히 지원합니다.
- **이식성 제로 의존성**: 표준 디렉토리 구조로, 공식 CLI와 완전히 호환됩니다.
- **Mise 버전 관리 지원**: 원클릭 설치 / 전환 / 업그레이드가 가능합니다.

---

## 📦 설치 방법 (하나 선택)

### 옵션 1: mise를 통한 설치 (권장 ✅)

1. mise 설치
```bash
curl https://mise.run | sh
```

2. 셸에서 mise 활성화
```bash
echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
source ~/.bashrc
```

3. 최신 opencode-portable 전역 설치
```bash
mise install github:zeronesun/opencode-portable@latest
mise use -g opencode-portable@latest
```

4. 설치 확인
```bash
opencode --version
which opencode
```

### 옵션 2: 수동 설치 (버전 관리자 없이)

1. 폴더 생성 및 아카이브 압축 해제
```bash
mkdir -p ~/opencode-portable
tar -xzf opencode-*-portable-linux-*.tar.gz -C ~/opencode-portable
```

2. PATH에 추가
```bash
echo 'export PATH="$HOME/opencode-portable/opencode/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

3. 설치 확인
```bash
opencode --version
which opencode
```

---

## ✅ 확인 단계 (모든 방법 공통)
아래 명령어를 실행하여 설치가 성공적으로 완료되었는지 확인하세요:

버전 확인
```bash
opencode --version
```

바이너리 경로 확인
```bash
which opencode
```

직접 실행
```bash
opencode
```

---

## ❌ ~/.local/bin에 심볼릭 링크를 사용하지 않는 이유
`opencode`는 동일 폴더에 있는 바이너리에 의존하는 래퍼 스크립트입니다.
스크립트만 심볼릭 링크하면 의존성 누락 오류가 발생합니다. 전체 bin 디렉토리를 PATH에 추가하는 것이 가장 안정적인 방법입니다.

---

## ❓ 자주 묻는 질문
### 1. 어떤 변형을 선택해야 합니까?
- 주요 Linux (Ubuntu/Debian): **glibc** 빌드 사용
- 레거시 / NAS 시스템: **musl** 빌드 사용

### 2. Ubuntu에서 musl 빌드가 오류가 발생합니까?
musl은 Ubuntu의 기본 glibc와 호환되지 않습니다. 일반 사용자는 **glibc** 버전만 사용해야 합니다.

### 3. 업그레이드 방법은 무엇입니까?
- mise 사용: `mise upgrade opencode-portable`
- 수동: 최신 아카이브를 재다운로드하여 교체

---

## 📜 라이센스
[anomalyco/opencode](https://github.com/anomalyco/opencode)를 기반으로 빌드되었으며, MIT 라이센스를 따릅니다.

## 📜 License
基于官方 [anomalyco/opencode](https://github.com/anomalyco/opencode) 构建，遵循 MIT 协议

## ⭐ Star History

<a href="https://www.star-history.com/?repos=zeronesun%2Fopencode-portable&type=date&legend=top-left">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/chart?repos=zeronesun/opencode-portable&type=date&theme=dark&legend=top-left" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/chart?repos=zeronesun/opencode-portable&type=date&legend=top-left" />
   <img alt="Star History Chart" src="https://api.star-history.com/chart?repos=zeronesun/opencode-portable&type=date&legend=top-left" />
 </picture>
</a>
