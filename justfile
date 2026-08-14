set shell := ["bash", "-cu"]

default: list

# Show available commands.
list:
	@just --list --unsorted

# Verify Typst, fonts, and required files are present.
doctor:
	@echo "Checking project setup..."
	@command -v typst >/dev/null 2>&1 && echo "✓ typst found" || (echo "✗ typst missing" && exit 1)
	@[ -f resume.typ ] && echo "✓ resume.typ found" || (echo "✗ resume.typ missing" && exit 1)
	@[ -f resume.json ] && echo "✓ resume.json found" || (echo "✗ resume.json missing" && exit 1)
	@[ -f lib/theme.typ ] && echo "✓ lib/theme.typ found" || (echo "✗ lib/theme.typ missing" && exit 1)
	@[ -f lib/helpers.typ ] && echo "✓ lib/helpers.typ found" || (echo "✗ lib/helpers.typ missing" && exit 1)
	@[ -f lib/components.typ ] && echo "✓ lib/components.typ found" || (echo "✗ lib/components.typ missing" && exit 1)
	@[ -f lib/sections.typ ] && echo "✓ lib/sections.typ found" || (echo "✗ lib/sections.typ missing" && exit 1)
	@typst fonts | grep -qi "Inter" && echo "✓ Inter font available" || echo "! Inter not found (fallback fonts will be used)"

# Build both resume PDFs once.
build: build-designed build-ats

# Build the designed (two-column) resume.
build-designed:
	mkdir -p build
	typst compile resume.typ build/ari-lerner-resume.pdf

# Build the single-column, parser-safe resume for application portals.
build-ats:
	mkdir -p build
	typst compile resume-ats.typ build/ari-lerner-resume-ats.pdf

# Show what an ATS / automated screener actually reads.
check-ats: build-ats
	pdftotext build/ari-lerner-resume-ats.pdf -

# Rebuild whenever files change.
watch:
	mkdir -p build
	typst watch resume.typ build/ari-lerner-resume.pdf

# Watch for changes and open the PDF viewer.
watch-open:
	mkdir -p build
	typst watch resume.typ build/ari-lerner-resume.pdf & \
	pid=$!; \
	sleep 1; \
	(open build/ari-lerner-resume.pdf || xdg-open build/ari-lerner-resume.pdf || true); \
	wait $$pid

# Open the generated PDF.
open:
	(open build/ari-lerner-resume.pdf || xdg-open build/ari-lerner-resume.pdf)

# Remove build artifacts.
clean:
	rm -rf build
