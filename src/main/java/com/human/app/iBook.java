package com.human.app;

import java.sql.Date;
import java.util.ArrayList;

public interface iBook {
	ArrayList<Booklist> getBookList();
	void doDeleteBook(int roomcode);
	void doAddBook(int roomcode,int roompriceall,int bookingpeople,String bookingname, String bookdate1, String bookdate2, String mobile);
}
