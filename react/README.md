# React Practice

Practice repository for React concepts and algorithms implementation.

## Structure

- `concepts/` - React components implementing various concepts
- `tests/` - Vitest tests for the components
- `scripts/` - Build and test scripts
- `.devcontainer/` - VS Code Dev Container configuration

## Usage

### Development with Dev Container

1. Open in VS Code
2. Reopen in Container when prompted
3. Start the dev server: `npm run dev`
4. Run tests: `npm run test`

### Local Development

```bash
npm install
npm run dev     # Start development server
npm run test    # Run tests with Vitest
npm run build   # Build for production
```

### Docker Usage

#### Development Container
```bash
docker build -t react-practice:dev --target dev .
docker run -it -p 5173:5173 -v $(pwd):/workspace react-practice:dev
```

#### Production Runtime
```bash
docker build -t react-practice:runtime --target runtime .
docker run -p 80:80 react-practice:runtime
```

## Concepts Implemented

- **Counter**: Basic state management with hooks
- **TodoList**: List management, CRUD operations
- More concepts to be added...

## Testing

Using Vitest with React Testing Library:
- Unit tests for components
- Integration tests for user interactions
- Test UI available at `npm run test:ui`

## Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run test` - Run tests in watch mode
- `npm run test:run` - Run tests once
- `npm run test:ui` - Open Vitest UI
- `npm run lint` - Run ESLint
- `npm run format` - Format code with Prettier