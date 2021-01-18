package com.example.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Diary {

	private Integer id;
	private String contents;
	private Date created;
	private String title;
	private String feeling;

}