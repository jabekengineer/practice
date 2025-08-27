const concept = process.argv[2];
if (!concept) {
  console.error("Please provide a concept argument.");
  process.exit(1);
}
import { spawn } from 'child_process';
const entry = `concepts/${concept}.ts`;
spawn('npx', ['tsc', entry, '--outDir', 'dist'], { stdio: 'inherit' });