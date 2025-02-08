# Define the directory where your markdown files are located
MD_DIR := .

# Output directories
HTML_DIR := ./html
PDF_DIR := ./pdf

# Define the pandoc command
PANDOC := pandoc

# Define pandoc options
PANDOC_OPTS := --standalone

MD_FILES := $(shell find $(MD_DIR) -type f -name "*.md")
HTML_FILES := $(patsubst $(MD_DIR)/%.md,$(HTML_DIR)/%.html,$(subst ','\'',$(MD_FILES)))
PDF_FILES := $(patsubst $(MD_DIR)/%.md,$(PDF_DIR)/%.pdf,$(subst ','\'',$(MD_FILES)))

# Default target: convert all markdown files to HTML
all: $(HTML_FILES) $(PDF_FILES)

# Rule to convert markdown files to HTML
$(HTML_DIR)/%.html: $(MD_DIR)/%.md | $(HTML_DIR)
	echo $(MD_FILES) $(HTML_FILES)
	$(PANDOC) $(PANDOC_OPTS) -o $@ "$<"

# Rule to convert markdown files to PDF
$(PDF_DIR)/%.pdf: $(MD_DIR)/%.md | $(PDF_DIR)
	$(PANDOC) $(PANDOC_OPTS) -o $@ "$<" --pdf-engine=wkhtmltopdf

# Create the HTML directory if it doesn't exist
$(HTML_DIR):
	mkdir -p $(HTML_DIR)

# Create the PDF directory if it doesn't exist
$(PDF_DIR):
	mkdir -p $(PDF_DIR)

# Clean generated HTML files
clean:
	rm -rf $(HTML_DIR)
	rm -rf $(PDF_DIR) 

.PHONY: all clean
