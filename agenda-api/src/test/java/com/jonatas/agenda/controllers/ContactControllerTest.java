package com.jonatas.agenda.controllers;

import static io.restassured.module.mockmvc.RestAssuredMockMvc.given;
import static io.restassured.module.mockmvc.RestAssuredMockMvc.standaloneSetup;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.ArgumentMatchers.isA;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.doReturn;
import static org.mockito.Mockito.doThrow;

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
		doReturn(new ArrayList<Contact>()).when(this.contactRepository).findAll();
		given().accept(ContentType.JSON).when().get("contacts/get").then().statusCode(HttpStatus.OK.value());
		
	}
	
	@Test
	public void success_findById() {
		doReturn(Optional.of(new Contact())).when(this.contactRepository).findById(anyLong());
		given().accept(ContentType.JSON).when().get("contacts/get/{Id}", 2L).then().statusCode(HttpStatus.OK.value());
		
	}
	
	@Test
	public void failure_findById() {
		doThrow(new RuntimeException()).when(this.contactRepository).findById(anyLong());
		given().accept(ContentType.JSON).when().get("contacts/get/{Id}", 2L).then().statusCode(HttpStatus.NOT_FOUND.value());
		
	}
	
	@Test
	public void success_saveContact() {
		doReturn(new Contact()).when(this.contactRepository).save(isA(Contact.class));
		given().contentType(ContentType.JSON).body(new Contact()).when().post("contacts/post").then().statusCode(HttpStatus.CREATED.value());
	
	}
	
	@Test
	public void failure_saveContact() {
		doThrow(new RuntimeException()).when(this.contactRepository).save(isA(Contact.class));
		given().contentType(ContentType.JSON).body(new Contact()).when().post("contacts/post").then().statusCode(HttpStatus.BAD_REQUEST.value());
	
	}
	
	@Test
	public void success_updateContact() {
		doReturn(Optional.of(new Contact())).when(this.contactRepository).findById(anyLong());
		doReturn(new Contact()).when(this.contactRepository).save(new Contact());
		given().contentType(ContentType.JSON).body(new Contact()).when().put("contacts/put/{id}", 2L).then().statusCode(HttpStatus.ACCEPTED.value());
	
	}
	
	@Test
	public void failure_updateContact() {
		doThrow(new RuntimeException()).when(this.contactRepository).findById(anyLong());
		doThrow(new RuntimeException()).when(this.contactRepository).save(isA(Contact.class));
		given().contentType(ContentType.JSON).body(new Contact()).when().put("contacts/put/{id}", 2L).then().statusCode(HttpStatus.NOT_FOUND.value());
	
	}
	
	@Test
	public void success_delete() {
		doNothing().when(this.contactRepository).deleteById(anyLong());
		given().contentType(ContentType.JSON).when().delete("contacts/delete/{id}", 2L).then().statusCode(HttpStatus.OK.value());

	}
	
	@Test
	public void failure_delete() {
		doThrow(new RuntimeException()).when(this.contactRepository).deleteById(anyLong());
		given().contentType(ContentType.JSON).when().delete("contacts/delete/{id}", 2L).then().statusCode(HttpStatus.NOT_FOUND.value());

	}
}
