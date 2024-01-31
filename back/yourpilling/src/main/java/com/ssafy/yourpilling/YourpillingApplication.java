package com.ssafy.yourpilling;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication
public class YourpillingApplication {

	public static void main(String[] args) {
		SpringApplication.run(YourpillingApplication.class, args);
	}

}
