package pl.edu.kkula.zadanie3.model

data class AuthResponse(
    val success: Boolean,
    val message: String,
    val username: String? = null
)
