package br.com.houseparty.housepartyapi.model;

import lombok.Getter;

import javax.persistence.*;
import java.util.List;

@Getter
@Entity
@Table(name = "endereco")
public class Address {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "logradouro", nullable = false)
    private String street;
    @Column(name = "numero", nullable = false)
    private Long number;
    @Column(name = "complemento", nullable = true)
    private String complement;
    @Column(name = "bairro", nullable = false)
    private String neighborhood;
    @Column(name = "cidade", nullable = false)
    private String city;
    @OneToMany
    private List<User> users;
}
