package com.wei.bookclub.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.wei.bookclub.models.LoginUser;
import com.wei.bookclub.models.User;
import com.wei.bookclub.services.UserService;


@Controller
public class MainController {
	
	// -- for test only
//	@GetMapping("/")
//	public String test() {
//		return "index.jsp";
//	}
	
	// ---- User Registration and User Log route from index ----
	@Autowired
	private UserService userService;
	
	// ---- route for display either user and log in POST request ----
    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("newUser", new User());
        model.addAttribute("newLogin", new LoginUser());
        return "/user/index.jsp";
    }
    
    // ---- POST request for register ----
    @PostMapping("/register")
    public String register(
    		@Valid
    		@ModelAttribute("newUser") User newUser, 
            BindingResult result,
            Model model,
            HttpSession session) {
    	
    	userService.register(newUser, result);
    	
        if(result.hasErrors()) {
            model.addAttribute("newLogin", new LoginUser());
            return "/user/index.jsp";
        }
        
        session.setAttribute("user_id", newUser.getId());
        return "redirect:/books";
    }
   
    
    // ---- POST request for log in ----
    @PostMapping("/login")
    public String login(
    		@Valid
    		@ModelAttribute("newLogin") LoginUser newLogin,
            BindingResult result,
            Model model,
            HttpSession session) {
    	
        User user = userService.login(newLogin, result);
        
        if(result.hasErrors()) {
            model.addAttribute("newUser", new User());
            return "index.jsp";
        }
        
        session.setAttribute("user_id", user.getId());
        return "redirect:/";
    }
}
