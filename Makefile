# No default value for PROBLEM_DIR
PROBLEM_DIR ?=

# Define the source file and output executable if FOLDER is specified
SRC := $(PROBLEM_DIR)/main.cpp
OUT_DIR := $(PROBLEM_DIR)/out_dir

COMMONFLAGS := \
			   -std=c++17 \
			   -pedantic \
			   -Wshadow

CXXFLAGS := \
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
		    -Wno-sign-compare

CLANGFLAGS := \
			  -fsyntax-only \
		      -Wdocumentation \
		      -Wconversion \
		      -Wfloat-conversion \
		      -Wno-implicit-float-conversion \
		      -Wno-sign-conversion \
		      -Wno-invalid-source-encoding \
		      -Wno-shorten-64-to-32

CHECKFLAGS := \
		      --enable=all \
		      --inconclusive \
		      --std=c++17 \
		      --suppress=missingIncludeSystem

# CODE_FILES := `ls *.cpp *.hpp`
# This needs a bit more thinking
CODE_FILES := $(SRC)

all: check-folder $(PROBLEM_DIR) \
	clean \
	cxx-compile \
	clang-check \
	cppcheck-check \
	run-test

cxx-compile:
	@echo "Compile with g++."
	g++ $(COMMONFLAGS) $(CXXFLAGS) -o $(OUT_DIR)/cxx-out.o $(SRC)

clang-check:
	@echo "Do clang++."
	clang++ $(COMMONFLAGS) $(CLANGFLAGS) $(CODE_FILES)

cppcheck-check:
	@echo "Do cppcheck."
	cppcheck $(CHECKFLAGS) $(CODE_FILES)

run-test:
	@echo "Run the output."
	./$(OUT_DIR)/cxx-out.o

clean: check-folder
	@echo "Remove the output directory."
	rm -f $(OUT_DIR)
	mkdir $(OUT_DIR)

# Check if FOLDER is set
check-folder:
	@if [ -z "$(PROBLEM_DIR)" ]; then \
		echo "Error: PROBLEM_DIR is not specified. Use 'make PROBLEM_DIR=\"$(pwd)/<problem_dir>\"' to specify the absolute directory."; \
		exit 1; \
	fi

.PHONY: all cxx-compile-test clang-check cppcheck-check run-test clean check-folder

