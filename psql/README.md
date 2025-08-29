# PostgreSQL Practice Repository

A lean PostgreSQL development environment for practicing SQL concepts with automated testing using pgTAP.

## Structure

```
psql/
├── concepts/           # SQL concept files (1:1 with tests)
│   └── hello.sql      # Hello world basic queries
├── tests/             # pgTAP test files
│   └── test_hello.sql # Tests for hello.sql
├── data/
│   └── schema.sql     # Minimal database schema
├── scripts/
│   ├── demo.sh        # Demo runner script
│   └── setup-database.sh # Database setup script
└── docker-compose.yml # Container orchestration
```

## Quick Start

### Option 1: Using Docker Compose (Recommended)

1. **Build the containers:**

   ```bash
   docker compose build
   ```

2. **Run a concept demo:**

   ```bash
   docker compose run --rm demo hello
   ```

3. **Start development environment:**

   ```bash
   docker compose up dev -d
   ```

### Option 2: Using Dev Container

1. **Open in VS Code Dev Container**
   - Open the folder in VS Code
   - Click "Reopen in Container" when prompted

2. **Start PostgreSQL and setup database:**

   ```bash
   ./scripts/start-postgres.sh
   ```

3. **In another terminal, run demos:**

   ```bash
   ./scripts/demo-devcontainer.sh hello
   ```

## Usage

### Running Concept Demos

Each concept has a corresponding test file following the pattern:
- `concepts/{name}.sql` ↔ `tests/test_{name}.sql`

To run a specific concept and its tests:
```bash
docker compose run --rm demo {concept_name}
```

Example:
```bash
docker compose run --rm demo hello
```

### Manual Development

Start the development container:
```bash
docker compose up dev -d
```

Connect to PostgreSQL:
```bash
docker compose exec dev psql -U postgres -d sql_practice
```

### Adding New Concepts

1. Create `concepts/new_concept.sql`
2. Create `tests/test_new_concept.sql` 
3. Run: `docker compose run --rm demo new_concept`

## What's Included

- **PostgreSQL 16** with pgTAP testing extension
- **Minimal schema** with demo data
- **1:1 concept-to-test** relationship
- **Automated demo runner** 
- **Clean, lean Docker setup**

## Example: Hello World

**Concept** (`concepts/hello.sql`):
```sql
-- Basic hello world query
SELECT 'Hello, World!' as greeting;
```

**Test** (`tests/test_hello.sql`):
```sql
SELECT is(
    (SELECT 'Hello, World!' as greeting),
    'Hello, World!',
    'Hello world query should return greeting'
);
```

**Run it:**
```bash
docker compose run --rm demo hello
```
