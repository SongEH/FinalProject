package first.final_project.util;

public class Paging {

	// 페이징 처리를 위한 HTML 코드를 생성하는 메서드
	public static String getPaging(String pageURL, int nowPage, int rowTotal, int blockList, int blockPage) {

		// 전체 페이지 수 계산 (총 데이터 개수를 한 페이지당 보여줄 개수로 나눔)
		int totalPage = (rowTotal + blockList - 1) / blockList;

		// 현재 블록에서 시작 페이지 번호를 계산
		int startPage = ((nowPage - 1) / blockPage) * blockPage + 1;

		// 현재 블록에서 마지막 페이지 번호를 계산
		int endPage = startPage + blockPage - 1;

		// 마지막 페이지 번호가 전체 페이지 수보다 크면, 마지막 페이지 번호를 전체 페이지 수로 제한
		if (endPage > totalPage)
			endPage = totalPage;

		// 이전 페이지가 있는지 여부를 판단 (현재 블록의 시작 페이지가 1보다 크면 true)
		boolean isPrevPage = (startPage > 1);

		// 다음 페이지가 있는지 여부를 판단 (현재 블록의 마지막 페이지가 전체 페이지보다 작으면 true)
		boolean isNextPage = (endPage < totalPage);

		// HTML 코드를 담을 StringBuffer 생성
		StringBuffer sb = new StringBuffer("<ul class='pagination'>");

		// ----- 이전 페이지 처리 -----
		if (isPrevPage) {
			// 이전 블록의 마지막 페이지로 이동하는 링크 생성
			sb.append(String.format("<li><a href='%s&page=%d'>◀</a></li>", pageURL, startPage - 1));
		} else {
			// 이전 페이지가 없을 때 비활성화 처리
			sb.append("<li><a href='#'>◀</a></li>");
		}

		// ----- 페이지 번호 출력 -----
		for (int i = startPage; i <= endPage; i++) {
			if (i == nowPage) { // 현재 페이지인 경우
				sb.append(String.format("<li class='active'><a href='#'>%d</a></li>", i));
			} else { // 현재 페이지가 아닌 경우
				sb.append(String.format("<li><a href='%s&page=%d'>%d</a></li>", pageURL, i, i));
			}
		}

		// ----- 다음 페이지 처리 -----
		if (isNextPage) {
			// 다음 블록의 첫 번째 페이지로 이동하는 링크 생성
			sb.append(String.format("<li><a href='%s&page=%d'>▶</a></li>", pageURL, endPage + 1));
		} else {
			// 다음 페이지가 없을 때 비활성화 처리
			sb.append("<li><a href='#'>▶</a></li>");
		}

		// HTML 태그 닫기
		sb.append("</ul>");

		// 최종 생성된 HTML 문자열 반환
		return sb.toString();
	}
}
