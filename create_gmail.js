const puppeteer = require('puppeteer');

async function createAccount() {
    const browser = await puppeteer.launch({
        headless: false,
        executablePath: '/usr/bin/firefox'  // Ensure this path is correct for Firefox
    });

    const page = await browser.newPage();
    await page.goto('https://accounts.google.com/signup');

    // Wait for the first name input field and type in the details
    await page.waitForSelector('input[name="firstName"]');
    await page.type('input[name="firstName"]', 'John');
    await page.type('input[name="lastName"]', 'Doe');

    // Generate a random username
    await page.type('input[name="Username"]', 'john.doe' + Math.floor(Math.random() * 10000));

    // Set the password and confirm password
    await page.type('input[name="Passwd"]', 'Password123!');
    await page.type('input[name="ConfirmPasswd"]', 'Password123!');

    // Click Next button to proceed with the sign-up
    await page.click('#accountDetailsNext');
    await page.waitForNavigation();

    // Take a screenshot after the page has loaded
    await page.screenshot({ path: '/tmp/gmail_account_creation.png' });

    // Close the browser after the task is completed
    await browser.close();
}

// Start the account creation process
createAccount();
