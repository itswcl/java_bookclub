package com.wei.bookclub.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.wei.bookclub.models.Book;

public interface BookRepo extends CrudRepository<Book, Long> {
	List<Book> findAll();
}
