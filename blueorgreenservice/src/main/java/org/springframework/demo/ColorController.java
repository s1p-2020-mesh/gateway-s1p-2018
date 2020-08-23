package org.springframework.demo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author Ryan Baxter
 */
@RestController
public class ColorController {

	private static final Logger log = LoggerFactory.getLogger(ColorController.class);

	private ColorProperties colorProperties;

	public  ColorController(ColorProperties colorProperties) {
		this.colorProperties = colorProperties;
	}

	@RequestMapping
	public Color color() throws InterruptedException {
		log.info("Got request for " + colorProperties.getColor());
		if(colorProperties.isSlow()) {
			log.info("Sleeping for 5s...");
			Thread.sleep(5000);
		}
		log.info("Sending response for " + colorProperties.getColor());
		if(Color.BLUE.getId().equalsIgnoreCase(colorProperties.getColor())) {
			return Color.BLUE;
		} else if(Color.YELLOW.getId().equalsIgnoreCase(colorProperties.getColor())) {
			return Color.YELLOW;
		}
		return Color.GREEN;
	}

	static class Color {
		public static final Color GREEN = new Color("green");
		public static final Color BLUE = new Color("blue");
		public static final Color YELLOW = new Color("yellow");
		private String id;

		public Color(){}

		public Color(String id) { this.id = id; }

		public String getId() {
			return id;
		}

		public void setId(String id) {
			this.id = id;
		}
	}
}
