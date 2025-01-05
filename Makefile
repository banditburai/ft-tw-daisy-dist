.PHONY: run build-css setup dev all clean

# Default target
all: setup build-css run

# Environment detection
UNAME := $(shell uname)
ARCH := $(shell uname -m)

# Determine platform-specific binary name
ifeq ($(UNAME), Darwin)
    OPEN_CMD := open
    ifeq ($(ARCH), arm64)
        BINARY_NAME := tailwindcss-macos-arm64
    else
        BINARY_NAME := tailwindcss-macos-x64
    endif
else ifeq ($(UNAME), Linux)
    OPEN_CMD := xdg-open
    ifeq ($(ARCH), aarch64)
        BINARY_NAME := tailwindcss-linux-arm64
    else
        BINARY_NAME := tailwindcss-linux-x64
    endif
else
    OPEN_CMD := start
    BINARY_NAME := tailwindcss-windows-x64.exe
endif

# Setup (ensure binary is executable and styles exist)
setup:
	@echo "Setting up Tailwind..."
	@if not exist "tailwindcss" if not exist "tailwindcss.exe" ( \
		echo "Downloading Tailwind binary..." && \
		curl -sLO https://github.com/banditburai/ft-tw-daisy-dist/releases/latest/download/$(BINARY_NAME) && \
		move $(BINARY_NAME) tailwindcss \
	)
	@if [ "$(UNAME)" != "Windows_NT" ]; then chmod +x tailwindcss; fi
	@if not exist "styles" mkdir styles
	@if not exist "styles\input.css" ( \
		echo "Creating styles/input.css..." && \
		echo @import "tailwindcss"; > styles/input.css && \
		echo @plugin "daisyui"; >> styles/input.css \
	)

# Build CSS
build-css: setup
	@echo "Building CSS..."
	./tailwindcss -i styles/input.css -o styles/output.css

# Run the application (standard Python)
run:
	python main.py

# Development mode with watch (standard Python)
dev: setup
ifeq ($(OS),Windows_NT)
	start /B tailwindcss -i styles/input.css -o styles/output.css --watch
	python main.py
else
	./tailwindcss -i styles/input.css -o styles/output.css --watch & python main.py
endif

# UV-specific targets (requires UV to be installed: https://github.com/astral-sh/uv)
uv-run: build-css
	uv run main.py

uv-dev: setup
ifeq ($(OS),Windows_NT)
	start /B tailwindcss -i styles/input.css -o styles/output.css --watch
	uv run main.py
else
	./tailwindcss -i styles/input.css -o styles/output.css --watch & uv run main.py
endif

# Clean built files
clean:
	-rm -f styles/output.css 2>nul || del /F /Q styles\output.css

# Deep clean (removes everything including binary)
deep-clean:
	-rm -f styles/output.css tailwindcss 2>nul || del /F /Q styles\output.css tailwindcss.exe