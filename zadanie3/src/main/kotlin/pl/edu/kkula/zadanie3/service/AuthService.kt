package pl.edu.kkula.zadanie3.service

import pl.edu.kkula.zadanie3.model.AuthResponse


interface AuthService {

    /** Nazwa wariantu singletona (do celów informacyjnych). */
    val singletonType: String

    /** Symulacja autoryzacji użytkownika. */
    fun authenticate(username: String, password: String): AuthResponse
}
