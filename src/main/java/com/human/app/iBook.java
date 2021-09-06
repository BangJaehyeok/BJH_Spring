package com.human.app;

import java.sql.Date;

public interface iBook {
	void doDeleteBook(String roomname);
	void doAddBook(int roompriceall,int bookingpeople,String bookdate, String bookingname, String mobile);
}
