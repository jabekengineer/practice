BUILD_DIR = build

# Learning loop targets
help:
	@echo "=== C++ Learning Loop (90-minute cycles) ==="
	@echo ""
	@echo "Standard workflow:"
	@echo "  make concept CONCEPT=name    # Full learning cycle"
	@echo "  make test                    # Run all tests"
	@echo ""
	@echo "Learning loop components:"
	@echo "  make debug                   # Debug build (-O0 -g)"
	@echo "  make llvm-ir                 # Generate LLVM IR"
	@echo "  make gdb FILE=executable     # Launch GDB session"
	@echo "  make asan                    # AddressSanitizer build"
	@echo "  make coverage                # Coverage analysis"
	@echo ""
	@echo "Individual test execution:"
	@echo "  make test-char               # Run char_test"
	@echo "  make test-int                # Run int_test"

# Full 90-minute learning cycle
concept:
	@if [ -z "$(CONCEPT)" ]; then echo "Usage: make concept CONCEPT=name"; exit 1; fi
	@echo "🎯 Starting 90-minute learning cycle for concept: $(CONCEPT)"
	@echo "📝 Phase 1: Write tests (5-10 min)"
	@echo "   Edit tests/$(CONCEPT)_test.cpp"
	@read -p "Press Enter when tests are written..."
	@echo ""
	@echo "🔨 Phase 2: Implement code (15-25 min)"
	$(MAKE) debug
	@echo "   Edit concepts/$(CONCEPT).cpp/.hpp"
	@read -p "Press Enter when implementation is ready..."
	@echo ""
	@echo "🔍 Phase 3: Inspect LLVM IR (10 min)"
	$(MAKE) llvm-ir CONCEPT=$(CONCEPT)
	@echo ""
	@echo "🐛 Phase 4: Debug with GDB (15-20 min)"
	@echo "   Run: make gdb FILE=test_$(CONCEPT)"
	@read -p "Press Enter when debugging is complete..."
	@echo ""
	@echo "🛡️ Phase 5: ASan analysis (5-10 min)"
	$(MAKE) asan
	@echo ""
	@echo "📊 Phase 6: Coverage analysis (5-10 min)"
	$(MAKE) coverage
	@echo ""
	@echo "📚 Phase 7: Reflect and note (5 min)"
	@echo "   What surprised you in IR/asm/debugger?"
	@echo "   What C++ rule did this make concrete?"

# Debug build
debug:
	cmake -S . -B $(BUILD_DIR) -DCMAKE_BUILD_TYPE=Debug
	cmake --build $(BUILD_DIR)

# LLVM IR generation
llvm-ir:
	@if [ -z "$(CONCEPT)" ]; then echo "Usage: make llvm-ir CONCEPT=name"; exit 1; fi
	@echo "🔍 Generating LLVM IR for $(CONCEPT)..."
	mkdir -p $(BUILD_DIR)/ir
	# Try _ir.cpp first, fallback to .cpp
	@if [ -f "concepts/$(CONCEPT)_ir.cpp" ]; then \
	    echo "Using $(CONCEPT)_ir.cpp for IR generation..."; \
	    clang++ -S -emit-llvm -O0 -std=c++23 \
	        -I concepts \
	        concepts/$(CONCEPT)_ir.cpp \
	        -o $(BUILD_DIR)/ir/$(CONCEPT)_ir.ll; \
	else \
	    echo "Using $(CONCEPT).cpp for IR generation..."; \
	    clang++ -S -emit-llvm -O0 -std=c++23 \
	        -I concepts \
	        concepts/$(CONCEPT).cpp \
	        -o $(BUILD_DIR)/ir/$(CONCEPT).ll; \
	fi
	@echo ""
	cat $(BUILD_DIR)/ir/$(CONCEPT)_ir.ll;

# GDB debugging session - generic for any executable
gdb:
	@if [ -z "$(FILE)" ]; then \
		echo "Usage: make gdb FILE=executable_name"; \
		echo "Examples:"; \
		echo "  make gdb FILE=test_int        # Debug int tests"; \
		echo "  make gdb FILE=char_test       # Debug char tests"; \
		echo "  make gdb FILE=concepts/int_ir # Debug concept IR"; \
		exit 1; \
	fi
	$(MAKE) debug
	@echo "🐛 Starting GDB session for $(FILE)..."
	@echo "Useful GDB commands:"
	@echo "  (gdb) break main"
	@echo "  (gdb) break filename.cpp:line_number"
	@echo "  (gdb) break function_name"
	@echo "  (gdb) run [arguments]"
	@echo "  (gdb) step / next / continue"
	@echo "  (gdb) print variable_name"
	@echo "  (gdb) info locals"
	@echo "  (gdb) bt                        # Show backtrace"
	@echo "  (gdb) disassemble"
	@echo ""
	@if [ -f "./$(BUILD_DIR)/tests/$(FILE)" ]; then \
		echo "Debugging test executable: $(FILE)"; \
		gdb -x gdb_init.gdb ./$(BUILD_DIR)/tests/$(FILE); \
	elif [ -f "./$(BUILD_DIR)/$(FILE)" ]; then \
		echo "Debugging executable: $(FILE)"; \
		gdb -x gdb_init.gdb ./$(BUILD_DIR)/$(FILE); \
	elif [ -f "./$(FILE)" ]; then \
		echo "Debugging file: $(FILE)"; \
		gdb -x gdb_init.gdb ./$(FILE); \
	else \
		echo "❌ Executable not found: $(FILE)"; \
		echo "Available test executables:"; \
		ls -la $(BUILD_DIR)/tests/ 2>/dev/null | grep -E '^-.*x.*' || echo "  (none found)"; \
		echo "Available build executables:"; \
		find $(BUILD_DIR) -type f -executable -not -path "*/CMakeFiles/*" 2>/dev/null || echo "  (none found)"; \
		exit 1; \
	fi

# AddressSanitizer build
asan:
	@echo "🛡️ Building with AddressSanitizer..."
	cmake -S . -B $(BUILD_DIR) -DCMAKE_BUILD_TYPE=ASan
	cmake --build $(BUILD_DIR)
	@echo "Running tests with ASan..."
	ctest --test-dir $(BUILD_DIR) --verbose

# Coverage analysis
coverage:
	@echo "📊 Generating coverage report..."
	cmake -S . -B $(BUILD_DIR) -DCMAKE_BUILD_TYPE=Coverage
	cmake --build $(BUILD_DIR)
	ctest --test-dir $(BUILD_DIR)
	@echo "Generating HTML coverage report..."
	mkdir -p $(BUILD_DIR)/coverage
	lcov --capture --directory $(BUILD_DIR) --output-file $(BUILD_DIR)/coverage/coverage.info
	lcov --remove $(BUILD_DIR)/coverage/coverage.info '/usr/*' '*/tests/*' --output-file $(BUILD_DIR)/coverage/coverage_filtered.info
	genhtml $(BUILD_DIR)/coverage/coverage_filtered.info --output-directory $(BUILD_DIR)/coverage/html
	@echo "   Coverage report: $(BUILD_DIR)/coverage/html/index.html"

# Enhanced test targets
test: debug
	ctest --test-dir $(BUILD_DIR) --verbose

test-%: debug
	./$(BUILD_DIR)/tests/test_$*

# Clean all build artifacts
clean:
	rm -rf $(BUILD_DIR)

.PHONY: help concept debug llvm-ir gdb asan coverage test test-% clean
