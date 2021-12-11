package com.wei.bookclub.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wei.bookclub.models.Book;
import com.wei.bookclub.repositories.BookRepo;

@Service
public class BookService {
	@Autowired
	private BookRepo bookRepo;

// CRUD
	// READ ALL
	public List<Book> displayBooks() {
		return bookRepo.findAll();
	}
	
	
	// READ ONE
	public Book displayBook(Long book_id) {
		Optional<Book> optionalBook = bookRepo.findById(book_id);
		
		if (optionalBook.isPresent()) {
			return optionalBook.get();
		} else {
			return null;
		}
	}
	
	
	// CREATE and UPDATE one
	public Book createBook(Book book) {
		return bookRepo.save(book);
	}
	
	
	// DELETE ONE
	public void removeBook(Long book_id) {
		bookRepo.deleteById(book_id);
	}
}
