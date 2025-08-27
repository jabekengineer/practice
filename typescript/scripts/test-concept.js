const concept = process.argv[2];
if (!concept) {
  console.error("Please provide a concept argument.");
  process.exit(1);
}

import { spawn } from 'child_process';
spawn('npx', ['vitest', 'run', `tests/${concept}.test.ts`], { stdio: 'inherit' });