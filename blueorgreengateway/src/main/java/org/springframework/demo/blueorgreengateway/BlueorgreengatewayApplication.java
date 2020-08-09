package org.springframework.demo.blueorgreengateway;

import java.util.HashMap;
import java.util.Map;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.loadbalancer.LoadBalancerClient;
import org.springframework.cloud.gateway.filter.LoadBalancerClientFilter;
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.web.server.ServerHttpSecurity;
import org.springframework.security.web.server.SecurityWebFilterChain;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class BlueorgreengatewayApplication {

	public static void main(String[] args) {
		SpringApplication.run(BlueorgreengatewayApplication.class, args);
	}

	@Bean
	public RouteLocator routeLocator(RouteLocatorBuilder builder) {
		return builder.routes()
				// To demo without circuit breaker (call to slowgreen will wait - slowgreen takes 5s)
				//.route(p -> p.path("/blueorgreen").uri("lb://blueorgreen"))
				// To demo with circuit breaker (call to slowgreen will time out after ~1s - validate in Chrome->Developer Tools)
				//.route(p -> p.path("/blueorgreen").filters(f -> f.hystrix(c -> c.setName("cmd"))).uri("lb://blueorgreen"))
				// To demo with circuit breaker & fallback (call to slowgreen will return red)
				.route(p -> p.path("/blueorgreen").filters(f -> f.hystrix(c -> c.setName("cmd").setFallbackUri("forward:/colorfallback"))).uri("lb://blueorgreen"))
				.route(p -> p.path("/").or().path("/color").or().path("/js/**").uri("lb://blueorgreenfrontend"))
				.build();
	}

	@Bean
	public LoadBalancerClientFilter loadBalancerClientFilter(LoadBalancerClient client) {
		return new CustomLoadBalancerClientFilter(client);
	}

	@Configuration
	public class SecurityConfig {

		@Bean
		public SecurityWebFilterChain springSecurityFilterChain(ServerHttpSecurity http) {
			http.requestCache().disable().authorizeExchange().anyExchange().permitAll();
			return http.build();
		}
	}

	@RequestMapping("/colorfallback")
	public Map<String, String> fallbackColor() {
		Map<String, String> map = new HashMap<>();
		map.put("id", "red");
		return map;
	}
}
