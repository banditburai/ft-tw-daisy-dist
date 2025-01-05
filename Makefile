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

# Optional features (can be enabled with make SOUND=1 BROWSER=1)
SOUND ?= 0
BROWSER ?= 0

# Setup (ensure binary is executable and styles exist)
setup:
	@echo "Setting up Tailwind..."
	@if [ ! -f "tailwindcss" ]; then \
		echo "Downloading Tailwind binary..."; \
		LATEST_URL=$$(curl -s https://api.github.com/repos/banditburai/ft-tw-daisy-dist/releases/latest | grep "browser_download_url.*$(BINARY_NAME)" | cut -d '"' -f 4); \
		curl -sLO $$LATEST_URL; \
		mv $(BINARY_NAME) tailwindcss; \
	fi
	@chmod +x tailwindcss
	@mkdir -p styles
	@if [ ! -f "styles/input.css" ]; then \
		echo "Creating styles/input.css..."; \
		echo '@import "tailwindcss";' > styles/input.css; \
		echo '@plugin "daisyui";' >> styles/input.css; \
	fi

# Build CSS
build-css: setup
	@echo "Building CSS..."
	./tailwindcss -i styles/input.css -o styles/output.css

# Run the application
run:
	@if [ "$(BROWSER)" = "1" ]; then \
		(sleep 1 && $(OPEN_CMD) http://localhost:5001) & \
	fi
	@if [ "$(SOUND)" = "1" ]; then \
		if [ "$(UNAME)" = "Darwin" ]; then \
			afplay /System/Library/Sounds/Purr.aiff & \
		elif [ "$(UNAME)" = "Linux" ]; then \
			paplay /usr/share/sounds/freedesktop/stereo/complete.oga & \
		elif [ "$(UNAME)" = "MINGW64_NT-10.0" ]; then \
			powershell -c '(New-Object Media.SoundPlayer "C:\Windows\Media\notify.wav").PlaySync();' & \
		fi; \
	fi
	uv run main.py

# Development mode with watch
dev: setup
	./tailwindcss -i styles/input.css -o styles/output.css --watch & uv run main.py

# Clean built files
clean:
	rm -f styles/output.css

# Deep clean (removes everything including binary)
deep-clean:
	rm -f styles/output.css
	rm -f tailwindcss