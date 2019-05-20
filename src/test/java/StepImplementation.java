
import com.thoughtworks.gauge.Step;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

import static org.junit.Assert.assertEquals;

public class StepImplementation {

    private static WebDriver driver;

    @Step("Navigate to <https://www.utest.com>")
    public void navigateTo(String url) throws InterruptedException {
        System.setProperty("webdriver.chrome.driver", "/driver/chromedriver");

        ChromeOptions options = new ChromeOptions();
        options.addArguments("--headless");
        //options.addArguments("--disable-gpu");
        driver = new ChromeDriver(options);
        driver.get(url);
        //driver.manage().window().maximize();
        Thread.sleep(2000);
    }

    @Step("The page must contain the text value <JOIN UTEST>")
    public void verifySearchResult(String resultString) {
        WebElement result = driver.findElement(By.xpath("//*[@id=\"mainContent\"]/div/div/div/a"));
        assertEquals(resultString, result.getText());
        driver.close();
    }
}
