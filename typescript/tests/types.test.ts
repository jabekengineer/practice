
import {
	str,
} from '../concepts/types.js';

import { describe, it, expect } from 'vitest';
describe('Basic Types', () => {
	it('should assign string', () => {
		expect(str).toBeTypeOf('string');
		expect(str).toBe('hello');
	});
});
