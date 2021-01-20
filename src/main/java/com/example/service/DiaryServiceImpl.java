package com.example.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dao.DiaryDao;
import com.example.domain.Diary;

@Service
@Transactional(rollbackFor = Exception.class)
public class DiaryServiceImpl implements DiaryService{

	@Autowired
	DiaryDao diaryDao;

	//全取得
	@Override
	public List<Diary> getDiaryList() throws Exception {
		return diaryDao.selectAll();
	}

	//ID別取得
	@Override
	public Diary getDiaryById(Integer id) throws Exception {
        return diaryDao.selectById(id);
	}

	@Override
	public List<Diary> getDiaryByCreated(Date created) throws Exception {
		return diaryDao.selectByCreated(created);
	}

	//追加
	@Override
	public void addDiary(Diary diary) throws Exception {
		diaryDao.insert(diary);

	}

	//更新
	@Override
	public void updateDiary(Diary diary) throws Exception {
		diaryDao.update(diary);

	}

	//削除
	@Override
	public void deleteDiary(Integer id) throws Exception {
		diaryDao.delete(id);
	}





}