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
import com.example.service.DiaryService;

@Controller
@RequestMapping("/diary")
public class DiaryController {

	@Autowired
	DiaryService service;

/**
 * 日記の全データ取得
 */

	@GetMapping
	public String show(Model model) throws Exception {
		model.addAttribute("diaries", service.getDiaryList());
		return "diary";
	}


/**
 * 日記の編集
 */
    @GetMapping("/editDiary/{id}")
    public String updateGet(
    		@PathVariable Integer id,
    		Model model) throws Exception {
    	model.addAttribute("diary", service.getDiaryById(id));

    	return "editDiary";
    }

    @PostMapping("/editDiary/{id}")
    public String updatePost(
    		@Valid Diary diary,
    		Errors errors) throws Exception {
    	if(errors.hasErrors()) {
    		return "editDiary";
    	}
    	service.updateDiary(diary);
    	return "redirect:/diary";
    }

/**
 * 日記の削除
 */
    @GetMapping("/deleteDiary/{id}")
    public String delete(
    		@PathVariable Integer id
    		) throws Exception {
    	service.deleteDiary(id);
    	return "redirect:/diary";

    }
}