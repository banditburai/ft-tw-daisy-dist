# FastHTML Tailwind + DaisyUI Distribution

Pre-built distribution of [Tailwind CSS](https://github.com/tailwindlabs/tailwindcss) with [DaisyUI](https://github.com/saadeghi/daisyui), optimized for FastHTML projects.

## Current Versions
- Tailwind CSS: v4.0.0-beta.8
- DaisyUI: v5.0.0-beta.1

> ⚠️ **Beta Notice**: This package uses beta versions of both Tailwind CSS and DaisyUI. While functional, APIs and features may change.

## Installation

### Option 1: Complete Template (Recommended)

1. Download and extract the template package:
```bash
curl -sLO https://github.com/banditburai/ft-tw-daisy-dist/releases/latest/download/fasthtml-template.zip
unzip fasthtml-template.zip
cd fasthtml-template
```

2. Run `make` to automatically download the appropriate binary and start your project

### Option 2: Manual Setup

1. Download the binary for your platform:
```bash
# For macOS ARM (M1/M2)
curl -sLO https://github.com/banditburai/ft-tw-daisy-dist/releases/latest/download/tailwindcss-macos-arm64

# For macOS Intel
curl -sLO https://github.com/banditburai/ft-tw-daisy-dist/releases/latest/download/tailwindcss-macos-x64

# For Linux x64
curl -sLO https://github.com/banditburai/ft-tw-daisy-dist/releases/latest/download/tailwindcss-linux-x64

# For Windows x64
curl -sLO https://github.com/banditburai/ft-tw-daisy-dist/releases/latest/download/tailwindcss-windows-x64.exe
```

2. Make the binary executable (Unix systems):
```bash
chmod +x tailwindcss-*
mv tailwindcss-* tailwindcss
```

## Usage

Basic usage:
```bash
make
```

With browser auto-open:
```bash
make run BROWSER=1
```

With sound notification:
```bash
make run SOUND=1
```

Development mode (with watch):
```bash
make dev
```

## Demo

The included `main.py` provides a minimal template to get started:
- Basic FastHTML setup with Tailwind CSS and DaisyUI
- You can build upon this template by adding your own components and styles.

## Directory Structure
```text
.
├── tailwindcss     # The Tailwind CSS binary
├── styles/
│   ├── input.css   # Your source CSS
│   └── output.css  # Generated CSS (after build)
└── main.py         # Demo FastHTML application
```

## Source Code
This is a distribution of:
- [tailwindcss/tailwindcss](https://github.com/tailwindlabs/tailwindcss)
- [saadeghi/daisyui](https://github.com/saadeghi/daisyui)

## License
This distribution includes code from multiple sources:
- Tailwind CSS: [MIT License](https://github.com/tailwindlabs/tailwindcss/blob/master/LICENSE)
- DaisyUI: [MIT License](https://github.com/saadeghi/daisyui/blob/master/LICENSE)
