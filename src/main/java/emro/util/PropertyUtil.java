package emro.util;

import org.springframework.core.io.ClassPathResource;

import java.io.IOException;
import java.util.Properties;

public class PropertyUtil {

	public static String getPropertyValue(String fileName, String propertyKey) {
		return getPropertyValue(fileName,propertyKey,null);
	}
	
	public static String getPropertyValue(String fileName, String propertyKey,String defaultValue) {
		Properties pro = new Properties();
		ClassPathResource cr = new ClassPathResource(fileName);
		try {
			pro.load(cr.getInputStream());
			return pro.getProperty(propertyKey, defaultValue);
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
	}
}
