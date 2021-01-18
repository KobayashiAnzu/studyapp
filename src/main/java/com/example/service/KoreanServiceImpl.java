package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dao.KoreanDao;
import com.example.domain.Korean;

@Service
@Transactional(rollbackFor = Exception.class)
public class KoreanServiceImpl implements KoreanService{

	@Autowired
	KoreanDao koreanDao;

	//全件取得
	@Override
	public List<Korean> getKoreanList() throws Exception {
		return koreanDao.selectAll();
	}

	//ランダムに全件取得
	@Override
	public List<Korean> getKoreanByRandom() throws Exception {
        return koreanDao.selectByRandom();
	}

	//カテゴリ別に取得
	@Override
	public List<Korean> getKoreanByCategory(String category) throws Exception {
	    return koreanDao.selectByCategory(category);
	}

	//ID別に取得
	@Override
	public Korean getKoreanById(Integer id) throws Exception {
		return koreanDao.selectById(id);
	}

	//追加
	@Override
	public void addKorean(Korean korean) throws Exception {
		koreanDao.insert(korean);
    }

    //ページネーション
	@Override
	public int getTotalPages(int numPerPage) throws Exception {
		double totalNum = (double) koreanDao.count();
		return (int) Math.ceil(totalNum / numPerPage);
	}

	@Override
	public List<Korean> getKoreanListByPage(int page, int numPerPage) throws Exception {
		int offset = numPerPage * (page - 1);
		return koreanDao.selectLimited(offset, numPerPage);
	}


    //更新
	@Override
	public void updateKorean(Korean korean) throws Exception {
		koreanDao.update(korean);
    }

	//削除
	@Override
	public void deleteKorean(Integer id) throws Exception {
		koreanDao.delete(id);
	}







}