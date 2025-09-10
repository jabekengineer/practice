%:
	psql -U postgres -f data/seed_$@.sql
	psql -f concepts/$@.sql
	pg_prove --verbose tests/test_$@.sql

list:
	$(info run `make concept` for one of following concepts)
	tree concepts