# No default value for PROBLEM_DIR
PROBLEM_DIR ?=

# Define the source file and output executable if FOLDER is specified
SRC = $(PROBLEM_DIR)/main.cpp
OUT = $(PROBLEM_DIR)/o.out

COMMONFLAGS=" \
			-std=c++17 \
		    -pedantic \
		    -Wshadow \
			"

CXXFLAGS=" \
		 -Weffc++ \
		 -Wall \
		 -Wextra \
		 -Wswitch-default \
		 -Wfloat-equal \
		 -Wundef \
		 -Wredundant-decls \
		 -Winit-self \
		 -Wparentheses \
		 -Wshadow \
		 -Wunreachable-code \
		 -Wuninitialized \
		 -Wmaybe-uninitialized \
		 -Wno-float-equal \
		 -Wno-sign-compare \
		 "

CLANGFLAGS=" \
		   -fsyntax-only \
		   -Wdocumentation \
		   -Wconversion \
		   -Wfloat-conversion \
		   -Wno-implicit-float-conversion \
		   -Wno-sign-conversion \
		   -Wno-invalid-source-encoding \
		   -Wno-shorten-64-to-32 \
		   "

CHECKFLAGS=" \
		   --enable=all \
		   --inconclusive \
		   --std=c++17 \
		   --suppress=missingIncludeSystem \
		   "

all: check-folder $(OUT)

$(OUT): $(SRC)
	g++ -std=c++11 -o $(OUT) $(SRC)

test: check-folder $(OUT)
	./$(OUT)

clean: check-folder
	rm -f $(FOLDER)/a.out

# Check if FOLDER is set
check-folder:
	@if [ -z "$(PROBLEM_DIR)" ]; then \
		echo "Error: PROBLEM_DIR is not specified. Use 'make PROBLEM_DIR=\"$(pwd)/<problem_dir>\"' to specify the absolute directory."; \
		exit 1; \
	fi

.PHONY: all test clean check-folder

