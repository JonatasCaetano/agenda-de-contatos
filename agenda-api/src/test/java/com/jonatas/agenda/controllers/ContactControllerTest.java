package com.jonatas.agenda.controllers;

import static io.restassured.module.mockmvc.RestAssuredMockMvc.given;
import static io.restassured.module.mockmvc.RestAssuredMockMvc.standaloneSetup;
import static org.mockito.Mockito.when;

import java.util.ArrayList;
import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.HttpStatus;

import com.jonatas.agenda.entities.Contact;
import com.jonatas.agenda.repositories.ContactRepository;

import io.restassured.http.ContentType;

@WebMvcTest
public class ContactControllerTest {

	@Autowired
	private ContactController contactController;
	
	@MockBean
	private ContactRepository contactRepository;
	
	@BeforeEach
	public void setup() {
		standaloneSetup(this.contactController);
	}
	
	@Test
	public void success_findAll() {
		when(this.contactRepository.findAll()).thenReturn(new ArrayList<Contact>());
		given().accept(ContentType.JSON).when().get("contacts/get").then().statusCode(HttpStatus.OK.value());
		
	}
	
	@Test
	public void success_findById() {
		when(this.contactRepository.findById(2L)).thenReturn(Optional.of(new Contact()));
		given().accept(ContentType.JSON).when().get("contacts/get/{Id}", 2L).then().statusCode(HttpStatus.OK.value());
		
	}
	
	@Test
	public void failure_findById() {
		when(this.contactRepository.findById(2L)).thenReturn(null);
		given().accept(ContentType.JSON).when().get("contacts/get/{Id}", 2L).then().statusCode(HttpStatus.NOT_FOUND.value());
		
	}
	
	
	
}
