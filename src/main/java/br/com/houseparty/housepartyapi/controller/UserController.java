package br.com.houseparty.housepartyapi.controller;

import br.com.houseparty.housepartyapi.model.User;
import br.com.houseparty.housepartyapi.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.servlet.http.HttpServletResponse;
import java.net.URI;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping
    public ResponseEntity<?> findAll() {
        List<User> users = userRepository.findAll();
        return !users.isEmpty() ? ResponseEntity.ok(users) : ResponseEntity.noContent().build();
    }

    @PostMapping
    @ResponseStatus(code = HttpStatus.CREATED)
    public void create(@RequestBody User user, HttpServletResponse servletResponse) {
        User userCreated = userRepository.save(user);
        URI uri = ServletUriComponentsBuilder.fromCurrentRequestUri().path("/id/{id}").buildAndExpand(userCreated.getId()).toUri();
        servletResponse.setHeader("Location", uri.toASCIIString());
    }

    @GetMapping("/id/{id}")
    public ResponseEntity<?> findById(@PathVariable Long id) {
        return userRepository.findById(id).map(
            value -> new ResponseEntity<User>(value, HttpStatus.OK)
        ).orElseGet(() -> new ResponseEntity<>(HttpStatus.NO_CONTENT));
    }

    @GetMapping("email/{email}")
    public ResponseEntity<User> findByEmail(@PathVariable String email){
        Optional<User> user = userRepository.findByEmailUser(email);
        return user.map(
            value -> new ResponseEntity<>(value, HttpStatus.OK)
        ).orElseGet(() -> new ResponseEntity<>(HttpStatus.NO_CONTENT)
        );
    }
    
    @GetMapping("/userName/{userName}")
    public ResponseEntity<User> findByUserName(@PathVariable String userName) {
        Optional<User> user = userRepository.findByUserName(userName);
        return user.map(
            value -> new ResponseEntity<User>(user.get(), HttpStatus.OK)
        ).orElseGet(
                () -> new ResponseEntity<>(HttpStatus.NO_CONTENT)
        );
    }

}
