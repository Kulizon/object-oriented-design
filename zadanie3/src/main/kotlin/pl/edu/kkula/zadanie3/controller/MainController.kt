package pl.edu.kkula.zadanie3.controller

import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import pl.edu.kkula.zadanie3.model.AuthRequest
import pl.edu.kkula.zadanie3.model.AuthResponse
import pl.edu.kkula.zadanie3.model.User
import pl.edu.kkula.zadanie3.service.AuthService

@RestController
@RequestMapping("/api")
class MainController(
    private val authService: AuthService
) {

    private val users: List<User> = listOf(
        User(1, "admin",  "admin@example.com",  "ADMIN"),
        User(2, "user",   "user@example.com",   "USER"),
        User(3, "editor", "editor@example.com",  "EDITOR"),
        User(4, "viewer", "viewer@example.com",  "VIEWER")
    )

    @GetMapping("/users")
    fun getUsers(): ResponseEntity<List<User>> {
        return ResponseEntity.ok(users)
    }

    @PostMapping("/login")
    fun login(@RequestBody request: AuthRequest): ResponseEntity<AuthResponse> {
        val result = authService.authenticate(request.username, request.password)
        val status = if (result.success) 200 else 401
        return ResponseEntity.status(status).body(result)
    }

    @GetMapping("/info")
    fun info(): ResponseEntity<Map<String, Any>> {
        return ResponseEntity.ok(
            mapOf(
                "singletonType" to authService.singletonType,
                "serviceClass"  to authService::class.simpleName.orEmpty(),
                "hashCode"      to authService.hashCode()
            )
        )
    }
}
