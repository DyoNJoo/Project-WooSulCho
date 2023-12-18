<%@page import="com.project.wsch.vo.WishListVO"%>
<%@page import="java.net.CookieManager"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.project.wsch.vo.PagingVO"%>
<%@page import="com.project.wsch.vo.ItemVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>


<link rel="styleSheet" href="/wsch/resources/css/itemlist.css">
<link rel="styleSheet" href="/wsch/resources/css/listanddetail.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
document.addEventListener("DOMContentLoaded", function () {
    // 푸터 숨기기
    var footer = document.querySelector("footer");
    if (footer) {
        footer.style.display = "none";
    }
});

</script>
</head>
<body>
<%
			// 여유 되면 컨트롤러쪽으로 코드 옮기기(더 깔끔하게)
			
			// 페이징을 위한 코드
			// db에서 가져온 결과 리스트 불러옴
			List<ItemVO> list = (List<ItemVO>)request.getAttribute("items");

			// 검색 했을 경우에 검색 결과 리스트를 저장할 벽수
			List<ItemVO> searchList;

			String type = (String)request.getAttribute("type");
			if(type == null || type.equals("all") || type.equals("")){
				request.setAttribute("type", "all");
			}
			PagingVO pagingVo;
			
			// 출력할 리스트의 페이징 기본값
			int currentPage = 1;
			int pageSize = 9;
									
			//리스트 새로 만들어주기...
			//어차피 카테고리마다 개수 다 세야해서 sql문을 수정하는 대신 리스트를 새로 만드는 방식으로 했다..
			List<ItemVO> outputLIst;
			
			
			// 출력할 데이터만 복사해주기
			// 검색했을 경우 실행되는 if문
			if((String)request.getAttribute("searchKeyword") != null){
				searchList = (List<ItemVO>)request.getAttribute("searchItems");

				if(type == null || type.equals("all") || type.equals("")){
					//타입 선택 x
					//outputList에 searchList를 복사해준다
					outputLIst = new ArrayList<ItemVO>(searchList);
				}else {
					// 타입 선택 o
					outputLIst = new ArrayList<ItemVO>();
					
					for(int i=0;i<searchList.size();i++){
						if(searchList.get(i).getType().equals(type)){
							outputLIst.add(searchList.get(i));
						}
					}
				}	
		        pagingVo = new PagingVO(currentPage, pageSize, outputLIst.size());
				request.setAttribute("totalSearch", outputLIst.size());

			}else{ //검색 안했을 경우
				if(type == null || type.equals("all") || type.equals("")){
					// 타입 선택 x
					outputLIst = new ArrayList<ItemVO>(list);
					
			        pagingVo = new PagingVO(currentPage, pageSize, outputLIst.size());

				}else{
					// 타입 선택 o
					outputLIst = new ArrayList<ItemVO>();
					
					for(int i=0;i<list.size();i++){
						if(list.get(i).getType().equals(type)){
							outputLIst.add(list.get(i));
						}
						if( type.equals("리큐르") && list.get(i).getType().equals("기타주류")){
							outputLIst.add(list.get(i));
						}
					}
					
			        pagingVo = new PagingVO(currentPage, pageSize, outputLIst.size());
				}
				
			} 
			//개수세기, 개수 담을 변수..
			int total = list.size();
			int total1 = 0;
			int total2 = 0;
			int total3 = 0;
			int total4 = 0;
			int total5 = 0;
			int total6 = 0;
			
			for(int i=0;i<list.size();i++){
				if(list.get(i).getType().equals("탁주")){
					total1++;
				}
				if(list.get(i).getType().equals("청주")){
					total2++;
				}
				if(list.get(i).getType().equals("약주")){
					total3++;
				}
				if(list.get(i).getType().equals("과실주")){
					total4++;
				}
				if(list.get(i).getType().equals("증류주")){
					total5++;
				}
				if(list.get(i).getType().equals("리큐르") || list.get(i).getType().equals("기타주류")){
					total6++;
				}
			}		
			
			
			List<WishListVO> wishList = (List<WishListVO>)request.getAttribute("wishList");
			//int test = wishList.get(1).getId();
			System.out.println(wishList);
			//request.setAttribute("test", test);
			
			
			session.setAttribute("total", total);
			session.setAttribute("total1", total1);
			session.setAttribute("total2", total2);
			session.setAttribute("total3", total3);
			session.setAttribute("total4", total4);
			session.setAttribute("total5", total5);
			session.setAttribute("total6", total6);


			
			request.setAttribute("outputList", outputLIst);
			request.setAttribute("outputSize", outputLIst.size());
			request.setAttribute("pagingVo", pagingVo);
		%>
	<div id="headerImg">
		<img src="https://img.freepik.com/premium-photo/boozy-makgeolli-korean-rice-wine-generative-ai_786587-12725.jpg">
	</div>
	<main>
	    <div id="topWrap">
	        <div id="bannerImg">
	            <img src="/wsch/resources/img/items/img_8343_1.png" alt="">
	        </div>
	        <div id="navBar">
	            <ul id="nav">
	                <li class=""><a href="?type=all">전체(${total })</a></li>
	                <li class=""><a href="?type=탁주">탁주(${total1 })</a></li>
	                <li class=""><a href="?type=청주">청주(${total2 })</a></li>
	                <li class=""><a href="?type=약주">약주(${total3 })</a></li>
	                <li class=""><a href="?type=과실주">과실주(${total4 })</a></li>
	                <li class=""><a href="?type=증류주">증류주(${total5 })</a></li>
	                <li class=""><a href="?type=리큐르">리큐르/기타(${total6 })</a></li>
	            </ul>
			</div>
	        <div id="searchBar" class="row_between">
	        	<div class="row rowStart">
	      	        <c:if test="${empty searchKeyword}">
	      	        	<p>카테고리 <span class="text_accent">${type }</span> 의 데이터 개수 : <span class="text_accent">${outputSize }</span> 개</p>
	        		</c:if>
	            	<c:if test="${not empty searchKeyword}">
		            	<p><span class="text_accent">${searchKeyword }</span> 의 검색 결과 : <span class="text_accent">${totalSearch }</span> 개</p>
	            	</c:if>
	            </div>
	            <div class="row rowEnd">
	            	<label>
	            		<input type="radio" class="form-check" name="searchOption" value="1" checked />이름으로 검색하기
	            	</label>
	            	<label>
	            		<input type="radio" class="form-check" name="searchOption" value="2" />특징으로 검색하기
	            	</label>
	            	
	            	<div id="searchBox">
	            		<input type="text" id="search" placeholder="검색어를 입력하세요" value="${searchKeyword }"/>
	            		<input type="button" id="searchButton" value="검색">
	            	</div>
	            	<input type="button" id="resetButton">
	            	           		
	            	
	            </div>            
	        </div>
	    </div>
		
	    <div id="product_list">
	    	<c:forEach var="product" items="${outputList }" varStatus="status" begin="${(currentPage-1)*pagingVo.pageSize }" end="${currentPage * pagingVo.pageSize - 1}">
	     	<div class="item" data-type="${product.type }">
	             <div class="image">
	                 <a href="${pageContext.servletContext.contextPath }/items/detail/${product.id}">
	                 <img class="productImg" src= ${product.img_prod } referrerpolicy="no-referrer">
	                 </a>
	             </div>
	             <div class="information">
	             	<div class="row">
	             		<a href="${pageContext.servletContext.contextPath }/items/detail/${product.id}">	             	
		             		<div class="title">${product.name } </div> 
						</a>
						<c:set var="roopChk" value="true" />
		                <c:forEach var="wish" items="${wishList }" varStatus="status">
		                 	<c:if test="${roopChk }">
		                 		<c:if test="${wish.id eq product.id}">
						        	<svg id="id_${product.id }" class="wish wished" xmlns="http://www.w3.org/2000/svg" height="20" width="20" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4 268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8c0 41.5 17.2 81.2 47.6 109.5z"/></svg>        	
		                 			<c:set var="roopChk" value="false"/>
		                 		</c:if>
		                 		<c:if test="${(wish.id ne product.id) and status.last }">
	        						<svg id="id_${product.id }" class="wish" xmlns="http://www.w3.org/2000/svg" height="20" width="20" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4 268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8c0 41.5 17.2 81.2 47.6 109.5z"/></svg>        	
		                 		</c:if>		                		
		               		</c:if>     	
		                </c:forEach>
                   </div>

	                 
	                 
	                 <div class="detail">
	                     <ul class="menuUl"> 
	                         <hr/>
	                         <li>	
	                             ${product.desc }
	                         </li>
	                         <hr/>
	                         <span class="detail_info">
	                         <li>종류 - ${product.type } </li>
	                         <li>주 원료 - ${product.materials }</li>
	                         <li>용량/도수 - ${product.amount } / ${product.abv } </li>
	                         <li>가격 - ${product.price }</li>
	                         </span>
	                     </ul>
	                 </div>
	             </div>
	         </div>
	    	</c:forEach>
		</div>
		
		
		<div class="paging">
<!-- 				<hr/>		
 -->		
			<c:if test="${pagingVo.totalPages > 1 }">
				<ul>
					<li><a href="javascript:buildQueryString(1);"> << 처음 </a></li>
<%-- 					<li><a href="?page=${currentPage eq 1 ? 1 : (currentPage - 1)}">이전</a></li>--%>					
					<c:forEach begin="1" end="${pagingVo.totalPages}" var="page">
                		<li><a href="javascript:buildQueryString(${page});" class="number">${page}</a></li>
            		</c:forEach>
<%--             		<li><a href="?page=${currentPage eq pagingVo.totalPages ? pagingVo.totalPages : (currentPage + 1)}">다음</a></li>--%>
					<li><a href="javascript:buildQueryString(${pagingVo.totalPages});"> 끝 >> </a></li>
				</ul>
			</c:if>
			
		</div>
	 </main>
<script>
	
	// 쿼리문을 만드는 함수
	function buildQueryString(page){
		
		// 그냥 변수명 짧게 하려고 담음
		var queryStr = window.location.search;
		
		if(queryStr == ''){
			// 아직 아무것도 선택하지 않았을 때
		 	window.location.href = window.location.href +"?page="+page;
		} else if(queryStr.indexOf("page") > -1){
			// 이미 page가 쿼리 스트링에 존재할 때
			var idx = queryStr.indexOf("page");
			
			// page 이후에 나오는 &부터 끝까지의 문자열
			// 	뒤에 &가 존재하지 않을 경우엔 page가 마지막 값이라는거니까 tail 비우기
			var tail;
			if(queryStr.indexOf("&",idx+1) > -1){
				tail = queryStr.substring(queryStr.indexOf("&",idx+1));
			}else{
				tail = "";
			}
		 	window.location.href = queryStr.substring(0, idx) +"page="+page+tail;		 	
		} else {
			// 다른 인덱스들이 이미 있고 아직 page를 선택하지 않았을 때
		 	window.location.href = window.location.href +"&page="+page;
		}
	}

	window.onload = function(){
		var type = console.log($(location).attr('search'));
	}
	 $(document).ready(function() {
		 
		 // 위시리스트
		 $(".wish").click(function(e){
				//로그인하지 않았을 경우
				<c:if test="${logStatus ne 'Y'}">
					alert("회원만 가능합니다.");
					return false;
				</c:if>
				
				//클릭당한놈의 아이디 가져오기
				var clickedId = $(this).attr('id');		
				
				//wish -> 이미 체크되어있으면 "on", 체크 안되어있으면 "off"
				var wish = "";
				if($(this).hasClass("wished")){
					wish = "on";
				}else {
					wish = "off";
				}
				
				var id = clickedId.substr(3);
				
				//ajax 요청 보내기
				$.ajax({
					url: "detail/wish",
					type: "POST",
					data: {
						id: id,
						wish: wish
					},
					success: function(data){
						console.log(wish);

						if(wish == "on"){
							console.log(wish);

							$("[id='"+clickedId+"']").removeClass("wished");
						}else if(wish == "off"){

							$("[id='"+clickedId+"']").addClass("wished");
						}
					},
					error: function(error){
						console.log(error);
					}
				});
				
			});
		 
		 
		 //카테고리, 페이징, 검색
	        // 현재 URL에서 type 값을 추출
	        var currentType = getParameterByName('type');
	        
	        // 현재 URL에서 page 인덱스 값을 추출
	        var currentPage = getParameterByName('page');
	        
	     	// 현재 URL에서 searchKeyword 값을 추출
	        var currentSearchKeyword = getParameterByName('searchKeyword');
	        
	     	// 현재 URL에서 searchOption 값을 추출
	     	var searchOption = getParameterByName('searchOption');
	     	$(".form-check[value='"+searchOption+"']").prop("checked", true);     	        

	        // page값이 null이면 첫번째 페이지이므로 1을 넣어주기
	        if(currentPage == null){
	        	currentPage = 1;
	        }        
	        
	        
	        // 페이징 꾸미기 
	        // 모든 page 번호에서 selected 클래스 제거
	       	$('.paging a').parent().removeClass('selected');
	        // 선택된 page에 selected 클래스 추가
	        $('.paging a[href*='+currentPage+']').filter(".number").parent().addClass('selected');
	        // type에 해당하는 링크에 'selected' 클래스 추가
	        $('#nav a[href="?type=' + currentType + '"]').parent().addClass('selected');
	        // 처음으로, 마지막으로 버튼 비활성화
			if(currentPage == 1){
		       	$('.paging li:first-child > a').addClass('disabled');

			}else if(currentPage == '${pagingVo.totalPages }'){
		       	$('.paging li:last-child > a').addClass('disabled');
	        }else{
		       	$('.paging li > a').removeClass('disabled');
	        }
	        
	        
	        // 카테고리 navBar 꾸미기
	        // 홈페이지 진입 시 전체 카테고리에 'selected' 클래스 추가
	        if (!currentType) {
	            $('#nav li:first-child').addClass('selected');
	        }
	        
	        // 클릭 이벤트 처리
	        $('#nav a').click(function(e) {
	            e.preventDefault(); // 기본 클릭 이벤트를 막음
	            
	            // 모든 항목에서 'selected' 클래스 제거
	            $('#nav a').parent().removeClass('selected');
	            
	            // 현재 클릭한 항목에 'selected' 클래스 추가
	            $(this).parent().addClass('selected');
	            
	            // 클릭한 링크로 이동
	            window.location.href = $(this).attr('href');
	        });
	        
	        
	        // 검색 버튼 클릭 이벤트
	        $('#searchButton').click(function(e){
	        	e.preventDefault();
	        	
	        	search();
	        });
	    	// 검색창에서 엔터키 누를 때 이벤트
	    	$('#search').keyup(function(e){
	        	e.preventDefault();
				if(e.keyCode == 13){
		        	search();
				}
	    	});
	    	$('#resetButton').click(function(e){	        	
	        	$('#search').val("");
	        });
	    	
	     

	        // URL에서 특정 매개변수 값을 추출하는 함수
	        function getParameterByName(name) {
	            name = name.replace(/[\[\]]/g, "\\$&");
	            var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
	                results = regex.exec(window.location.href);
	            
	            //console.log(results);
	            
	            if (!results) return null;
	            if (!results[2]) return '';
	            return decodeURIComponent(results[2].replace(/\+/g, " "));
	        }
	        
	     	// 검색하는 함수
	    	function search(){
	    		var searchKeyword = $('#search').val();
	        	var searchOption = $('.form-check:checked').val(); //1 또는 2
	        	
	        	// type 은 고려 안함
	        	// page 값은 무조건 1로 초기화된다.
	        	// 검색어를 쿼리 스트링에 추가한다
	            window.location.href = window.location.href.substring(0, window.location.href.indexOf("?")) +"?searchOption=" + searchOption + "&searchKeyword="+searchKeyword+"&page="+1;
	    	}
	        	       
	    });
</script>
</body>