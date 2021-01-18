package com.example.config; //<JFWP.05のP24>

import java.util.ResourceBundle;

import javax.servlet.Filter;
import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletRegistration.Dynamic;

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class DispatcherServletInitializer
       extends AbstractAnnotationConfigDispatcherServletInitializer{

	@Override
	protected Class<?>[] getRootConfigClasses() {
		// TODO 自動生成されたメソッド・スタブ
		return null;
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {

		return new Class[] {ApplicationConfig.class};
	}

    @Override
	protected String[] getServletMappings() {

		return new String[] {"/"};
	}

    //文字化け防止のフィルターを有効化
	@Override
	protected Filter[] getServletFilters() {
		var filter = new CharacterEncodingFilter();
		filter.setEncoding("UTF-8");
		filter.setForceEncoding(true);
		return new Filter[] { filter };
	}

	//ファイルアップロードの設定
	@Override
	protected void customizeRegistration(Dynamic registration) {
		var rb = ResourceBundle.getBundle("environment");
		String location = rb.getString("location.temp");
		long maxFileSize = 5242880;
		long maxRequestSize = 5242880;
		int fileSizeThreshold = 0;
		var config = new MultipartConfigElement(location, maxFileSize, maxRequestSize, fileSizeThreshold);
		registration.setMultipartConfig(config);

	}


}
