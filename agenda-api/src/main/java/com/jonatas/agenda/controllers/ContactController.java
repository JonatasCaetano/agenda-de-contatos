package com.jonatas.agenda.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jonatas.agenda.entities.Contact;
import com.jonatas.agenda.repositories.ContactRepository;

@RestController
@RequestMapping(value = "/contacts")
public class ContactController {

	@Autowired
	private ContactRepository contactRepository;
	
	@GetMapping(value = "/get")
	public ResponseEntity<List<Contact>> findAll(){
		List<Contact> contacts = contactRepository.findAll();
		return ResponseEntity.ok().body(contacts);
	}
	
	@GetMapping(value = "/get/{id}")
	public ResponseEntity<Contact> findById(@PathVariable Long id){
		try {
			Contact contact = contactRepository.findById(id).get();
			return ResponseEntity.ok().body(contact);
		}catch(RuntimeException e) {
			return ResponseEntity.notFound().build();
		}
	}
	
	@PostMapping(value = "/post")
	public ResponseEntity<Void> saveContact(@RequestBody Contact contact){
		try {
			contactRepository.save(contact);
			return ResponseEntity.created(null).build();
		}catch(RuntimeException e) {
			return ResponseEntity.badRequest().build();
		}
	}
	
	@PutMapping(value = "/put/{id}")
	public ResponseEntity<Void> updateContact(@RequestBody Contact contact, @PathVariable Long id){
		try {
			Contact obj = contactRepository.findById(id).get();
			obj.setName(contact.getName());
			obj.setPhone(contact.getPhone());
			contactRepository.save(obj);
			return ResponseEntity.accepted().build();
		}catch(RuntimeException e) {
			return ResponseEntity.notFound().build();
		}
	}
	
	@DeleteMapping(value = "delete/{id}")
	public ResponseEntity<Void> deleteContact(@PathVariable Long id){
		try {
			contactRepository.deleteById(id);
			return ResponseEntity.ok().build();
		}catch(RuntimeException e) {
			return ResponseEntity.notFound().build();
		}
	}
}
