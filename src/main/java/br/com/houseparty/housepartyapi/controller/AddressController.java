package br.com.houseparty.housepartyapi.controller;

import br.com.houseparty.housepartyapi.model.Address;
import br.com.houseparty.housepartyapi.repository.AddressRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("address")
public class AddressController {

    @Autowired
    AddressRepository addressRepository;

    @GetMapping
    public ResponseEntity<?> findAll() {
        List<Address> addresses = addressRepository.findAll();
        return !addresses.isEmpty() ? ResponseEntity.ok(addresses) : ResponseEntity.noContent().build();
    }

}
