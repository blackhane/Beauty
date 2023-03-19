package kr.co.beautyshop.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CartVO {
	private int cartNo;
	private String uid;
	private int prodNo;
	private String prodName;
	private int price;
	private int discount;
	private int disPrice;
	private int point;
	private int count;
	private String color;
	private String size;
	private String thumb1;
	private String rdate;
	
	//add
	public int getSalePrice() {
		return (price-disPrice);
	}
	
	public int getTotalPrice() {
		return (getSalePrice()*count);
	}
}
