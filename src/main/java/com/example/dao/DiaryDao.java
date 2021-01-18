package com.example.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.domain.Diary;
@Mapper
public interface DiaryDao {

	//全取得
	List<Diary> selectAll() throws Exception;

	//ID別取得
	Diary selectById(Integer id)throws Exception;

	//追加
	void insert(Diary diary) throws Exception;

	//更新
	void update(Diary diary)throws Exception;

	//削除
	void delete(Integer id)throws Exception;




}