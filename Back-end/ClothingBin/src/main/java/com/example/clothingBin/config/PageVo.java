package com.example.clothingBin.config;

public class PageVo {
    // 한페이지 게시물 게시수
    private int pageSize;
    // 첫 번째 페이지 번호
    private int firstPageNo;
    // 시작 페이지 (페이징 네비 기준)
    private int startPageNo;
    // 페이지 번호
    private int pageNumber;
    // 끝 페이지 (페이징 네비 기준)
    private int endPageNo;
    // 마지막 페이지 번호
    private int finalPageNo;
    // 게시 글 전체 수
    private int totalCount;
    // 페이징 수
    private int pageBlockSize;
    // 총 페이지 수
    private int pageCount;



    // 한페이지 게시물 게시수
    public int getPageSize() {
        return pageSize;
    }
    // 첫 번째 페이지 번호
    public int getFirstPageNo() {
        return firstPageNo;
    }
    // 시작 페이지 (페이징 네비 기준)
    public int getStartPageNo() {
        return startPageNo;
    }
    // 페이지 번호
    public int getPageNumber() {
        return pageNumber;
    }
    // 끝 페이지 (페이징 네비 기준)
    public int getEndPageNo() {
        return endPageNo;
    }
    // 마지막 페이지 번호
    public int getFinalPageNo() {
        return finalPageNo;
    }
    // 게시 글 전체 수
    public int getTotalCount() {
        return totalCount;
    }
    // 페이징 수
    public int getPageCount() {
        return pageCount;
    }



    public void setFirstPageNo(int firstPageNo) {
        this.firstPageNo = firstPageNo;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public void setStartPageNo(int startPageNo) {
        this.startPageNo = startPageNo;
    }

    public void setPageNumber(int pageNumber) {
        //if (pageNumber == 0 || pageNumber < 0) pageNumber = 1;
        this.pageNumber = pageNumber;
    }

    public void setEndPageNo(int endPageNo) {
        this.endPageNo = endPageNo;
    }

    public void setFinalPageNo(int finalPageNo) {
        this.finalPageNo = finalPageNo;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

    public void setPageBlockSize(int pageBlockSize) {
        this.pageBlockSize = pageBlockSize;
    }

    public PageVo() {
    }

    // 현재 페이지, 페이징크기
    public void calcStartEndPageNo(int pageNo, int pagingNo) {
        // (((현재페이지-1)/페이징크기)*페이징크기)*1
        //this.setStartPageNo( (((pageNo - 1) / pagingNo) * pagingNo) + 1 );
        this.setStartPageNo( ((pageNo + 1) / pagingNo) * pagingNo);

        int endPageNo = this.getStartPageNo() + pagingNo - 1;
        if ( endPageNo > this.getFinalPageNo() ) {
            endPageNo = this.getFinalPageNo();
        }
        this.setEndPageNo(endPageNo);
    }

    // 마지막 페이지 계산
    public void calcFinalPageNo(int totalCount, int pageSize) {
        this.setFinalPageNo((int) Math.ceil((double) totalCount / (double) pageSize));
        this.setFinalPageNo(this.getFinalPageNo()-1);
    }

    public void setPageCount() {
        this.pageCount = this.finalPageNo+1;
    }

    // 현재페이지, 페이지게시물수, 페이징위젯크기, 총게시물수
    public PageVo(int pageNumber, int pageSize, int pageBlockSize, int totalCount) {
        // 첫페이지 세팅
        setFirstPageNo(0);
        // 현재페이지
        setPageNumber(pageNumber);
        // 페이지게시물개수
        setPageSize(pageSize);
        // 페이징위젯크기
        setPageBlockSize(pageBlockSize);
        // 총게시물수
        setTotalCount(totalCount);
        // 마지막페이지번호
        calcFinalPageNo(getTotalCount(), getPageSize());
        // 페이징위젯 시작페이징번호, 끝페이징번호
        calcStartEndPageNo(pageNumber, pageBlockSize);
        // 총페이지수
        setPageCount();
    }
}
