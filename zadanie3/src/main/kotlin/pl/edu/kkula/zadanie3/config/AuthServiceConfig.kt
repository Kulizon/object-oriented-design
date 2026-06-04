package pl.edu.kkula.zadanie3.config

import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.context.annotation.Lazy
import pl.edu.kkula.zadanie3.service.AuthService
import pl.edu.kkula.zadanie3.service.EagerAuthService
import pl.edu.kkula.zadanie3.service.LazyAuthService

@Configuration
class AuthServiceConfig {

    @Bean
    @ConditionalOnProperty(name = ["auth.singleton-type"], havingValue = "eager", matchIfMissing = true)
    fun eagerAuthService(): AuthService {
        println("[Config] Wybrano EAGER singleton.")
        val service = EagerAuthService.INSTANCE
        println("[Config] Zarejestrowano AuthService: ${service.singletonType} (hashCode=${service.hashCode()})")
        return service
    }

    @Bean
    @Lazy
    @ConditionalOnProperty(name = ["auth.singleton-type"], havingValue = "lazy")
    fun lazyAuthService(): AuthService {
        println("[Config] Wybrano LAZY singleton.")
        val service = LazyAuthService.INSTANCE
        println("[Config] Zarejestrowano AuthService: ${service.singletonType} (hashCode=${service.hashCode()})")
        return service
    }
}
