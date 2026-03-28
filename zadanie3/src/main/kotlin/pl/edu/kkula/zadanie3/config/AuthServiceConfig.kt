package pl.edu.kkula.zadanie3.config

import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import pl.edu.kkula.zadanie3.service.AuthService
import pl.edu.kkula.zadanie3.service.EagerAuthService
import pl.edu.kkula.zadanie3.service.LazyAuthService

@Configuration
class AuthServiceConfig {

    @Bean
    fun authService(@Value("\${auth.singleton-type:eager}") singletonType: String): AuthService {
        val service = when (singletonType.lowercase()) {
            "lazy" -> {
                println("[Config] Wybrano LAZY singleton.")
                LazyAuthService.INSTANCE
            }
            else -> {
                println("[Config] Wybrano EAGER singleton.")
                EagerAuthService.INSTANCE
            }
        }
        println("[Config] Zarejestrowano AuthService: ${service.singletonType} (hashCode=${service.hashCode()})")
        return service
    }
}
