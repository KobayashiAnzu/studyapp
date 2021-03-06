package com.example.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.domain.Diary;
import com.example.domain.Korean;
import com.example.service.DiaryService;
import com.example.service.KoreanService;

@Controller
@RequestMapping("/korean")
public class KoreanController {


	@Autowired
	KoreanService service;

	@Autowired
	DiaryService service1;

/**
 * 単語の全データ取得
 */

	@GetMapping
	public String show(Model model) throws Exception {
	model.addAttribute("koreans", service.getKoreanList());

		return "korean";
	}

/**
 * 単語の追加
 */

	@GetMapping("/add")
	public String addGet(Model model) {
		model.addAttribute("korean", new Korean());
		return "add";
	}

	@PostMapping("/add")
	public String addPost(
			@Valid Korean korean,
			Errors errors
			) throws Exception {
		// 入力不備があるか確認
		if(errors.hasErrors()) {
			return "add";
		}

		// DBにデータ追加
		service.addKorean(korean);

		return "redirect:/korean";
	}

/**
 * 単語の更新
 */

	@GetMapping("/edit/{id}")
	public String updateGet(
			@PathVariable Integer id,
			Model model) throws Exception {

		model.addAttribute("korean", service.getKoreanById(id));

		return "edit";
	}

	@PostMapping("/edit/{id}")
	public String updatePost(
			@Valid Korean korean,
			Errors errors
			) throws Exception {
		if(errors.hasErrors()) {
			return "edit";
		}

		service.updateKorean(korean);

		return "redirect:/korean";
	}

/**
 * 単語の削除
 */

	@GetMapping("/delete/{id}")
	public String delete(
			@PathVariable Integer id
			) throws Exception {

		service.deleteKorean(id);

		return "redirect:/korean";
	}

/**
 * 日記の投稿
 */

		@PostMapping
		public String addDiaryPost(
				@Valid Diary diary,
				Errors errors
				) throws Exception {
			// 入力不備があるか確認
			if(errors.hasErrors()) {
				return "addDiary";
			}

			// DBにデータ追加
			service1.addDiary(diary);

			return "redirect:/korean";
		}



}