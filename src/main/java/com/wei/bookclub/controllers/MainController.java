package com.wei.bookclub.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;

import com.wei.bookclub.models.Book;
import com.wei.bookclub.models.LoginUser;
import com.wei.bookclub.models.User;
import com.wei.bookclub.services.BookService;
import com.wei.bookclub.services.UserService;

@Controller
public class MainController {

	// -- for test only
//	@GetMapping("/")
//	public String test() {
//		return "index.jsp";
//	}

	@Autowired
	private UserService userService;
	@Autowired
	private BookService bookService;

// ------------------------------------------------------------------------------------
	// ---- route for display both registration and login form ----
	@GetMapping("/")
	public String index(Model model, HttpSession session) {
		if (session.getAttribute("user_id") != null) {
			return "redirect:/books";
		}
		model.addAttribute("newUser", new User());
		model.addAttribute("newLogin", new LoginUser());
		return "/user/index.jsp";
	}

	// ---- POST request for register ---- ^^^^
	@PostMapping("/register")
	public String register(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, Model model,
			HttpSession session) {

		userService.register(newUser, result);

		if (result.hasErrors()) {
			model.addAttribute("newLogin", new LoginUser());
			return "/user/index.jsp";
		}

		session.setAttribute("user_id", newUser.getId());
		return "redirect:/books";
	}

	// ---- POST request for log in ---- ^^^^
	@PostMapping("/login")
	public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, BindingResult result, Model model,
			HttpSession session) {

		User user = userService.login(newLogin, result);

		if (result.hasErrors()) {
			model.addAttribute("newUser", new User());
			return "/user/index.jsp";
		}

		session.setAttribute("user_id", user.getId());
		return "redirect:/books";
	}

// ------------------------------------------------------------------------------------
	// ---- GET page for all books with the Logged User
	@GetMapping("/books")
	public String displayBooks(HttpSession session, Model model) {

		Long user_id = (Long) session.getAttribute("user_id");
		if (user_id == null) {
			return "redirect:/";
		} else {
			User user = userService.displayUser(user_id);
			model.addAttribute("user", user);
		}

		List<Book> books = bookService.displayBooks();
		model.addAttribute("books", books);
		return "/book/show.jsp";
	}

// ------------------------------------------------------------------------------------

	// Create a book GET ROUTE to show form
	@GetMapping("/books/new")
	public String formBook(@ModelAttribute("book") Book book, Model model, HttpSession session) {

		if (session.getAttribute("user_id") == null) {
			return "redirect:/";
		}

		model.addAttribute("user_id", session.getAttribute("user_id"));
		return "/book/new.jsp";
	}

	// Create a book POST ROUTE to sent form
	@PostMapping("/books/new")
	public String formBookCreate(@Valid @ModelAttribute("book") Book book, BindingResult result, Model model,
			HttpSession session) {

		if (result.hasErrors()) {
			return "book/new.jsp";
		} else {
			bookService.createBook(book);
			return "redirect:/books";
		}
	}

// ------------------------------------------------------------------------------------

	// display route for book detail
	@GetMapping("/books/{book_id}")
	public String displayBook(@PathVariable("book_id") Long book_id, HttpSession session, Model model) {

		Long user_id = (Long) session.getAttribute("user_id");
		if (user_id == null) {
			return "redirect:/";
		} else {
			User user = userService.displayUser(user_id);
			model.addAttribute("user", user);
		}

		model.addAttribute("user_id", user_id);

		Book book = bookService.displayBook(book_id);
		model.addAttribute("book", book);
		return "/book/detail.jsp";
	}

// ------------------------------------------------------------------------------------
	// display edit route // to use id as always
	@GetMapping("/books/edit/{book_id}")
	public String displayEdit(
			@PathVariable("book_id") Long book_id, HttpSession session, 
			Model model) {

		Long user_id = (Long) session.getAttribute("user_id");
		Book book = bookService.displayBook(book_id);

		if (user_id == null) {
			return "redirect:/";

		} else if (user_id.equals(book.getUser_id().getId())) {
			User user = userService.displayUser(user_id);
			model.addAttribute("user", user);
			model.addAttribute("book", book);
			return "/book/edit.jsp";

		} else {
			return "redirect:/";
		}

	}

	// PUT route // to use id as ALWAYS
	@PutMapping("/books/edit/{id}") // PUT route // to use id as ALWAYS
	public String bookEdit(@Valid @ModelAttribute("book") Book book, BindingResult result
			) {
		if (result.hasErrors()) {
			return "book/edit.jsp";
		} else {
			System.out.println(book.getId());
			System.out.println(book.getTitle());
			// re use create Language to update same ID pass in
			bookService.createBook(book);
			return "redirect:/books";
		}
	}
	
// ------------------------------------------------------------------------------------

	// --- LOG OUT
	@GetMapping("/books/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
}
