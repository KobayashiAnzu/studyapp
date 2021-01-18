package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.service.KoreanService;

@Controller
@RequestMapping("/quiz")
public class QuizController {

	//1ページ当たりの表示件数
	private static final int NUM_PER_PAGE = 3;

	@Autowired
	KoreanService service;

	@GetMapping
	public String quiz(
			@RequestParam(name = "page", defaultValue = "1") Integer page,
			Model model) throws Exception{
		model.addAttribute("koreans", service.getKoreanListByPage(page, NUM_PER_PAGE));
		model.addAttribute("page", page);
		model.addAttribute("totalPages", service.getTotalPages(NUM_PER_PAGE));
		return "quiz";
	}

}
