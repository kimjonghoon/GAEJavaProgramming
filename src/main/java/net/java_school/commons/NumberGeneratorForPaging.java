package net.java_school.commons;

public class NumberGeneratorForPaging {

    public NumbersForPaging getNumbersForPaging(int totalRecord, int page, int numPerPage, int pagePerBlock) {
        //총 페이지 수
        int totalPage = totalRecord / numPerPage;
        if (totalRecord % numPerPage != 0) {
            totalPage++;
        }

        //총 블록 수
        int totalBlock = totalPage / pagePerBlock;
        if (totalPage % pagePerBlock != 0) {
            totalBlock++;
        }

        //현재 블록
        int block = page / pagePerBlock;
        if (page % pagePerBlock != 0) {
            block++;
        }

        //현재 블록에 속한 첫 번째 페이지 번호와 마지막 페이지 번호
        int firstPage = (block - 1) * pagePerBlock + 1;
        int lastPage = block * pagePerBlock;

        //현재 블록이 1보다 크다면 [이전] 링크를 위한 페이지 번호 계산
        int prevPage = 0;
        if (block > 1) {
            prevPage = firstPage - 1;
        }

        //현재 블록이 총 블록 수(마지막 블록 번호)보다 작다면 [다음] 링크를 위한 페이지 번호 계산
        int nextPage = 0;
        if (block < totalBlock) {
            nextPage = lastPage + 1;
        }

        //현재 블록이 마지막 블록이라면 현재 블록의 마지막 페이지 번호를 총 페이지 수로 변경
        if (block >= totalBlock) {
            lastPage = totalPage;
        }

        //현재 페이지의 목록 아이템 앞에 붙일 번호 계산
        int listItemNo = totalRecord - (page - 1) * numPerPage;

        //현재 페이지의 목록을 위한 첫 번째 레코드 번호
        int offset = (page - 1) * numPerPage;

        NumbersForPaging ints = new NumbersForPaging();
        ints.setTotalPage(totalPage);
        ints.setFirstPage(firstPage);
        ints.setLastPage(lastPage);
        ints.setPrevPage(prevPage);
        ints.setNextPage(nextPage);
        ints.setListItemNo(listItemNo);
        ints.setOffset(offset);

        return ints;
    }

}
