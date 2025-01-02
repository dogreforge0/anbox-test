const puppeteer = require('puppeteer-core');

// Custom delay function using Promise and setTimeout
function delay(time) {
    return new Promise(resolve => setTimeout(resolve, time));
}

async function captureScreenshot() {
    try {
        const browser = await puppeteer.launch({
            headless: true,  // Headless mode (no UI)
            executablePath: '/usr/bin/firefox',  // Make sure Firefox is installed and available at this path
            timeout: 60000,  // Timeout for browser launch
            args: ['--no-sandbox', '--disable-setuid-sandbox'],  // Arguments to avoid sandbox issues
        });

        const page = await browser.newPage();
        await page.goto('https://accounts.google.com/signup');
        
        // Wait for 4 seconds to ensure the page has fully loaded
        await delay(4000);  // Use the custom delay function

        // Take a screenshot
        await page.screenshot({ path: '/tmp/gmail_account_creation.png' });
        
        console.log("Screenshot saved at /tmp/gmail_account_creation.png");

        await browser.close();
    } catch (error) {
        console.error('Error during screenshot capture:', error);
    }
}

captureScreenshot();
