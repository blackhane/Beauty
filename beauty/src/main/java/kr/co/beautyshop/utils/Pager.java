package kr.co.beautyshop.utils;

public class Pager {
	
	int currentPage = 1;	//현재 페이지
	int pageSize	= 10;	//페이지당 게시글 수
	int start		= 0;	//DB에서 Limit 시작점
	int articleNum	= 0;	//게시글 번호
	int totalPage	= 0;	//총 페이지
	int groupStart	= 0;	//현재 페이지 그룹 시작번호
	int groupEnd	= 0;	//현재 페이지 그룹 마지막번호
	
	//pg 받아온 현재페이지, totalCnt 전체 게시글 수
	public Pager(int pageSize, int pg, int totalCnt) {
		this.pageSize	= pageSize;
		this.currentPage= pg == 0 ? 1:pg;				//현재 페이지 할당
		this.start		= (this.currentPage-1) * pageSize;	//limit 시작점 할당
		this.articleNum	= totalCnt - this.start;			//게시글 번호 할당
		this.totalPage	= (int) Math.ceil(totalCnt /(double)pageSize); //총 페이지 할당
		this.groupStart = ((int) Math.ceil(currentPage / 10.0) -1) * 10 + 1; //1~10페이지면 1
		this.groupEnd	= Math.min(groupStart * 10, totalPage);				//1~10 페이지면 10 또는 총 페이지 수(더 작은 값)
	}
	
	
}