package com.human.app;

public interface iMember {
	void doJoin(String name,String loginid,String passcode);
	int doCheckUser(String userid,String passcode);
}
