.PHONY: run build-css setup dev all clean

# Default target
all: setup build-css run

# Environment detection
UNAME := $(shell uname)
OPEN_CMD := 
ifeq ($(UNAME), Darwin)
    OPEN_CMD := open
else ifeq ($(UNAME), Linux)
    OPEN_CMD := xdg-open
else
    OPEN_CMD := start
endif

# Optional features (can be enabled with make SOUND=1 BROWSER=1)
SOUND ?= 0
BROWSER ?= 0

# Setup (ensure binary is executable and styles exist)
setup:
	@echo "Setting up Tailwind..."
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