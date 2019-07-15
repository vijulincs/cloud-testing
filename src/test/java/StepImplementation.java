
import com.thoughtworks.gauge.Step;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.firefox.FirefoxBinary;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.ie.InternetExplorerDriver;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;

import java.net.MalformedURLException;
import java.net.URL;

import static org.junit.Assert.assertEquals;

public class StepImplementation {

    public static String browserType="";
public WebDriver driver ;
    @Step("Navigate to <url>")
    public void navigateTo(String url) throws InterruptedException {

        browserType = System.getenv("BROWSER");
        System.out.println("============================"+browserType);
        if (browserType.equalsIgnoreCase("CHROME")) {
            System.setProperty("webdriver.chrome.driver","driver/chromedriver");
            driver = new ChromeDriver();
            driver.get(url);
            Thread.sleep(2000);
        } else if (browserType.equalsIgnoreCase("FIREFOX")) {
            System.setProperty("webdriver.gecko.driver","driver/geckodriver");
             FirefoxOptions options = new FirefoxOptions();
            options.setHeadless(true);
            //driver = new FirefoxDriver(options);
            driver = new RemoteWebDriver(new URL("http://34.67.62.104:4444/grid/console"),options);
            driver.get(url);
            driver.manage().window().maximize();
            Thread.sleep(10000);
        }
        else if (browserType.equalsIgnoreCase("IE")) {
            System.setProperty("webdriver.ie.driver","/opt/cloud-testing/driver/IEDriverServer.exe");
            DesiredCapabilities capabilities = DesiredCapabilities.internetExplorer();
            capabilities.setCapability("ignnorezoomSetting",true);
            driver = new InternetExplorerDriver(capabilities);
            driver.get(url);
            Thread.sleep(5000);
        }
    }
    @Step("The page must contain the text value <text>")
    public void verifySearchResult(String resultString) {
        System.out.println("Current URL"+driver.getCurrentUrl());
        WebElement result = driver.findElement(By.id("menu-item-3085"));
        assertEquals(resultString, result.getText());
        driver.close();
    }
}
