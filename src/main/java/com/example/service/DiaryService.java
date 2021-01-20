package com.example.service;

import java.util.Date;
import java.util.List;

import com.example.domain.Diary;

public interface DiaryService {

	    //全件取得
		List<Diary> getDiaryList() throws Exception;

		//ID別に取得
		Diary getDiaryById(Integer id) throws Exception;

		//日付別に取得
		List<Diary> getDiaryByCreated(Date created) throws Exception;

		//追加
		void addDiary(Diary diary) throws Exception;

		//更新
		void updateDiary(Diary diary) throws Exception;

		//削除
		void deleteDiary(Integer id) throws Exception;


}