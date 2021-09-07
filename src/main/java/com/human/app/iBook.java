package com.human.app;

import java.sql.Date;

public interface iBook {
	void doDeleteBook(int roomcode);
	void doAddBook(int roomcode,int roompriceall,int bookingpeople,String bookdate, String bookingname, String mobile);
}
