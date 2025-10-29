import { test, expect } from '@playwright/test';

test.describe('DOM Document Concepts - Playwright/Real Browser', () => {
  test('should demonstrate document properties in real browser and compare with jsdom expectations', async ({
    page,
  }) => {
    // Visit the live page served by Vite
    await page.goto('/');

    // Evaluate in the page context to grab DOM properties
    const browserDOMInfo = await page.evaluate(() => {
      return {
        // Basic document properties
        nodeType: document.nodeType,
        documentElementTag: document.documentElement.tagName,
        constructorName: document.constructor.name,

        // Global context
        windowEqualsGlobalThis: window === globalThis,
        locationHref: window.location.href,

        // Document structure
        bodyExists: !!document.body,
        headExists: !!document.head,
        titleExists: !!document.title,

        // Sample of document.documentElement.outerHTML (first 200 chars)
        documentElementSample: document.documentElement.outerHTML.substring(
          0,
          200
        ),
      };
    });

    // Assert the same properties we tested in Vitest
    expect(browserDOMInfo.nodeType).toBe(9); // Should match jsdom
    expect(browserDOMInfo.documentElementTag).toBe('HTML'); // Should match jsdom
    expect(browserDOMInfo.constructorName).toBe('HTMLDocument'); // Different from jsdom!

    // Assert browser-specific properties
    expect(browserDOMInfo.windowEqualsGlobalThis).toBe(true); // Should match jsdom
    expect(browserDOMInfo.locationHref).toContain('localhost:3000'); // Should be similar to jsdom
    expect(browserDOMInfo.bodyExists).toBe(true);
    expect(browserDOMInfo.headExists).toBe(true);

    console.log('Real Browser Results:', browserDOMInfo);
  });

  test('should demonstrate DOM querying in real browser with actual page content', async ({
    page,
  }) => {
    await page.goto('/');

    // Test that we can find elements in the actual page
    const pageTitle = await page.locator('h3').first();
    await expect(pageTitle).toContainText('Learning CSS_HTML');

    // Test that we can interact with the DOM
    const mimeLink = await page.locator('a[href="/mime.html"]');
    await expect(mimeLink).toBeVisible();

    // Navigate to mime page and test DOM there
    await mimeLink.click();

    // Verify we're on the mime page and can access its DOM
    const mimeTitle = await page.locator('h3');
    await expect(mimeTitle).toContainText('Mime Types');

    // Test that the JavaScript in the page executed (check for MIME type displays)
    await page.waitForSelector('#txt-mime');
    const txtMimeElement = await page.locator('#txt-mime');
    await expect(txtMimeElement).toContainText('MIME type:');
  });

  test('should demonstrate runtime DOM introspection', async ({ page }) => {
    await page.goto('/mime.html');

    // Wait for the page's JavaScript to load the MIME content
    await page.waitForSelector('#txt-mime');

    // Evaluate complex DOM operations in browser context
    const domAnalysis = await page.evaluate(() => {
      // Find all elements with MIME type information
      const mimeElements = Array.from(
        document.querySelectorAll('[id$="-mime"]')
      );

      return {
        totalMimeElements: mimeElements.length,
        mimeElementsInfo: mimeElements.map((el) => ({
          id: el.id,
          textContent: el.textContent?.substring(0, 50), // First 50 chars
          hasContent: el.textContent ? el.textContent.length > 0 : false,
        })),
        documentReadyState: document.readyState,
        scriptsCount: document.querySelectorAll('script').length,
      };
    });

    expect(domAnalysis.totalMimeElements).toBeGreaterThan(0);
    expect(domAnalysis.documentReadyState).toBe('complete');
    expect(domAnalysis.scriptsCount).toBeGreaterThan(0);

    console.log('DOM Analysis:', domAnalysis);
  });
});
