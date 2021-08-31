package com.human.app;

public class Roomtype {
	private int typecode;
	private String name;
	public Roomtype() {}
	
	public int getTypecode() {
		return typecode;
	}
	public void setTypecode(int typecode) {
		this.typecode = typecode;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Roomtype(int typecode, String name) {
		//super();
		this.typecode = typecode;
		this.name = name;
	}
}