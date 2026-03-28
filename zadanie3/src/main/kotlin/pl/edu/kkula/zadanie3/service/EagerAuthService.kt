package pl.edu.kkula.zadanie3.service

import pl.edu.kkula.zadanie3.model.AuthResponse

class EagerAuthService private constructor() : AuthService {

    override val singletonType: String = "EAGER"

    private val users: Map<String, String> = mapOf(
        "admin"  to "admin123",
        "user"   to "password",
        "editor" to "edit456"
    )

    init {
        println("[EagerAuthService] Instancja EAGER singletona została utworzona natychmiast.")
    }

    override fun authenticate(username: String, password: String): AuthResponse {
        val storedPassword = users[username]
        return when {
            storedPassword == null -> AuthResponse(
                success = false,
                message = "Użytkownik '$username' nie istnieje."
            )
            storedPassword != password -> AuthResponse(
                success = false,
                message = "Nieprawidłowe hasło dla użytkownika '$username'."
            )
            else -> AuthResponse(
                success = true,
                message = "Autoryzacja pomyślna (singleton: $singletonType).",
                username = username
            )
        }
    }

    companion object {
        /**
         * Eager initialization – instancja tworzona od razu przy załadowaniu klasy.
         * Gwarantuje thread-safety dzięki mechanizmowi ładowania klas w JVM.
         */
        val INSTANCE: EagerAuthService = EagerAuthService()
    }
}
