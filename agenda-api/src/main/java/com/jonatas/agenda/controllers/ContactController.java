package com.jonatas.agenda.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jonatas.agenda.entities.Contact;
import com.jonatas.agenda.repositories.ContactRepository;

@RestController
@RequestMapping(value = "/contacts")
public class ContactController {

	@Autowired
	private ContactRepository contactRepository;
	
	@GetMapping
	public ResponseEntity<List<Contact>> findAll(){
		List<Contact> contacts = contactRepository.findAll();
		return ResponseEntity.ok().body(contacts);
	}
	
	@GetMapping(value = "/{id}")
	public ResponseEntity<Contact> findById(@PathVariable Long id){
		try {
			Contact contact = contactRepository.findById(id).get();
			return ResponseEntity.ok().body(contact);
		}catch(RuntimeException e) {
			return ResponseEntity.notFound().build();
		}
	}
	
}
