import { describe, it, expect, beforeEach } from 'vitest';

describe('DOM Document Concepts - Vitest/jsdom', () => {
  beforeEach(() => {
    // Start with a clean document
    document.body.innerHTML = '';
    document.title = 'Test Document';
  });

  it('should demonstrate basic document properties in jsdom', () => {
    // Test document.nodeType (should be 9 for Document node)
    expect(document.nodeType).toBe(9); // Node.DOCUMENT_NODE

    // Test document.documentElement.tagName (should be HTML)
    expect(document.documentElement.tagName).toBe('HTML');

    // Test document constructor
    expect(document.constructor.name).toBe('Document');

    console.log('JSDOM Results:', {
      nodeType: document.nodeType,
      documentElementTag: document.documentElement.tagName,
      constructorName: document.constructor.name,
    });
  });

  it('should demonstrate DOM querying and manipulation in jsdom', () => {
    // Create and inject a minimal HTML snippet
    const testElement = document.createElement('div');
    testElement.id = 'test-element';
    testElement.textContent = 'Hello from jsdom!';
    testElement.setAttribute('data-test', 'vitest');

    document.body.appendChild(testElement);

    // Query the element back and assert
    const found = document.getElementById('test-element');
    expect(found).not.toBeNull();
    expect(found?.textContent).toBe('Hello from jsdom!');
    expect(found?.getAttribute('data-test')).toBe('vitest');

    // Test querySelector
    const foundByQuery = document.querySelector('[data-test="vitest"]');
    expect(foundByQuery).toBe(testElement);

    // Verify document.body contains our element
    expect(document.body.children.length).toBe(1);
    expect(document.body.firstElementChild).toBe(testElement);
  });

  it('should demonstrate window and global context in jsdom', () => {
    // Test global context (window should equal globalThis in jsdom)
    expect(window === globalThis).toBe(true);

    // Test that document is accessible via window
    expect(window.document).toBe(document);

    // Test location object exists
    expect(window.location).toBeDefined();
    expect(window.location.href).toBe('http://localhost:3000/');

    console.log('JSDOM Global Context:', {
      windowEqualsGlobalThis: window === globalThis,
      locationHref: window.location.href,
      hasDocument: !!window.document,
    });
  });
});
