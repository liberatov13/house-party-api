package br.com.houseparty.housepartyapi.repository;

import br.com.houseparty.housepartyapi.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    @Query(value = "select * from usuario where email like ':email';", nativeQuery = true)
    Optional<User> findByEmailUser(@Param("email") String email);

    @Query(value = "select * from usuario where nome_usuario like ':userName';", nativeQuery = true)
    Optional<User> findByUserName(@Param("userName") String userName);

}
