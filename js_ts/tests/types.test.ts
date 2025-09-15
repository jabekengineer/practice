import {
	maxInt,
	minInt,
	str,
} from '../concepts/primitive-types.js';


import { describe, it, expect } from 'vitest';
describe('String Type Suite', () => {
	it('should have type string', () => {
		expect(str).toBeTypeOf('string');
	});
	it('should have runtime typeof string', () => {
		let actualType = typeof(str);
		expect(actualType).toBe('string');
	});
	it('can help', () => {
		expect(String.fromCharCode(8592)).toEqual("←");
		expect(typeof String.fromCharCode(1337)).toEqual("string");
	})
});

import {
	jsPrimitiveNumber,
	jsNumberWrapper,
	min,
	max
} from '../concepts/primitive-types.js'
describe('Numeric Type', () => {
	it('is just a number', () => {
		expect(jsPrimitiveNumber).toBeTypeOf('number');
	});
	it('is number emitted by JS number constructor', () => {
		expect(jsNumberWrapper).toBeTypeOf('number');
		expect(jsNumberWrapper.valueOf()).toBe(jsPrimitiveNumber);
	});
	it('is Number object', () => {
		expect(Number).toBeTypeOf('function');
	});
	it('Number defines numeric representation', () => {
		expect([min,max]).toEqual([5e-324, 1.7976931348623157e+308]);
	});
	it('Number defines numeric representation', () => {
		expect([minInt, maxInt]).toEqual([-9007199254740991,9007199254740991]);
	});
	it('Number has utility methods', () => {
		expect(Number.isNaN(Number.NaN)).toEqual(true);
		expect(Number.parseFloat(Number.NEGATIVE_INFINITY.toString())).toBeLessThan(5e-324);
		expect(Number.parseFloat(Number.POSITIVE_INFINITY.toString())).toBeGreaterThan(1.7976931348623157e+308);
	});
	it('Number utility method for base-2, base-16 radix', () => {
		expect(Number(6).toString(2)).toEqual('110');
		expect(Number(255).toString(16)).toEqual('ff');
	});
	it('Number extraction', () => {
		expect(Number('4')).toEqual(Number.parseInt('4'));
	})
});
