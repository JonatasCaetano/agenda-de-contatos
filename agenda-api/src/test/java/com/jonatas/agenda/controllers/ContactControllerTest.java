package com.jonatas.agenda.controllers;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;

import com.jonatas.agenda.repositories.ContactRepository;

import static io.restassured.module.mockmvc.RestAssuredMockMvc.*;

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
	public void teste() {
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
