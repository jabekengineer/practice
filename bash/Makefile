BINS := $(shell find concepts -type f -perm -111 -name '*.sh')
SRCS := $(shell find concepts -type f -name '*.sh')

.PHONY: fmt lint test cov ci


fmt:
	shfmt -w -i 2 -ci -bn $(SRCS)

lint:
	shellcheck $(SRCS)

test:
	CONCEPTS="/workspaces/practice/bash/concepts" \
	TESTS="/workspaces/practice/bash/tests" \
  DATA="/workspaces/practice/bash/data" \
	bats --print-output-on-failure tests

cov:
	# kcov per-script into coverage/; requires kcov installed
	mkdir -p coverage
	for s in $(BINS); do \
		kcov --include-path=$(PWD) coverage "$$s" || true; \
	done
	@echo "Coverage in ./coverage"

ci: fmt lint test
