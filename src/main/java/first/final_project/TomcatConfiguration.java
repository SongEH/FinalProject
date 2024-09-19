package first.final_project;

import org.apache.catalina.webresources.StandardRoot;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.apache.catalina.Context;

@Configuration
public class TomcatConfiguration {
    @Bean
    public WebServerFactoryCustomizer<TomcatServletWebServerFactory> servletContainerCustomizer() {
        return (TomcatServletWebServerFactory container) -> {
            container.addContextCustomizers((Context context) -> {
                  // This configuration is used to allow symlink on resources
                   StandardRoot sr = new StandardRoot();
                   sr.setAllowLinking(true);
                   context.setResources(sr);
            });
        };
    }
}
