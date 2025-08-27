const concept = process.argv[2];
if (!concept) {
  console.error("Please provide a concept argument.");
  process.exit(1);
}
import { spawn } from 'child_process';
const path = `concepts/${concept}.ts`;
spawn('npx', ['tsx', '--watch', path], { stdio: 'inherit' });