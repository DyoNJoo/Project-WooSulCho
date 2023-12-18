package com.project.wsch.vo;

public class PagingVO {
	private int currentPage;
	private int pageSize;
	private int totalItems;
	private int totalPages;
	
	public PagingVO() {
		// TODO Auto-generated constructor stub
	}
	
	public PagingVO(int currentPage, int pageSize, int totalItems) {
		super();
		this.currentPage = currentPage;
		this.pageSize = pageSize;
		this.totalItems = totalItems;
		if((totalItems % pageSize) == 0 ) {
			this.totalPages = totalItems / pageSize;
		}else {
			this.totalPages = (totalItems / pageSize) +1;
		}
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getTotalItems() {
		return totalItems;
	}
	public void setTotalItems(int totalItems) {
		this.totalItems = totalItems;
	}

	public int getTotalPages() {
		return totalPages;
	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}
	
	
}
