package com.project.wsch.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.project.wsch.vo.ItemDAO;
import com.project.wsch.vo.ItemVO;

@Service
public class ItemRecommendServiceImpl implements ItemRecommendService {
	 private final Map<Integer, ItemVO> itemrecmnd = new HashMap<Integer, ItemVO>();
	 
	 public ItemRecommendServiceImpl() {
	        // 아이템 데이터베이스 초기화 (더미 데이터 사용)
//	        itemrecmnd.put (1, new ItemRecommendVO (1, "삼양춘 생탁주", 5, 2, 3, "https://dbscthumb-phinf.pstatic.net/4776_000_1/20170524152908845_YH8ILUB46.jpg/fe87_173_i1.jpg?type=h345_fst_n&wm=Y"));
//	        itemrecmnd.put (2, new ItemRecommendVO (2, "삼양춘 생탁주", 4, 2, 1, "https://dbscthumb-phinf.pstatic.net/4776_000_1/20181013035355517_I7BH2GKXB.jpg/fe87_294_i1.jpg?type=m251&wm=Y"));
//	        itemrecmnd.put (3, new ItemRecommendVO (3, "인천 생 소성주", 2, 1, 2, "https://dbscthumb-phinf.pstatic.net/4776_000_1/20170224173842228_JAPYM0YLK.jpg/fe87_069_i1.jpg?type=m251&wm=Y"));
//	        itemrecmnd.put (4, new ItemRecommendVO (4, "산막 생유막걸리", 2, 1, 3, "https://dbscthumb-phinf.pstatic.net/4776_000_1/20170522193445714_N71Q2GOCS.JPG/fe87_191_i1.JPG?type=m251&wm=Y"));
//	        itemrecmnd.put (5, new ItemRecommendVO (5, "산막 대덕주", 4, 3, 1, "https://dbscthumb-phinf.pstatic.net/4776_000_1/20170522192030937_322OWD9YO.JPG/fe87_189_i1.JPG?type=m251&wm=Y"));
//	        itemrecmnd.put (6, new ItemRecommendVO (6, "석로주", 4, 1, 1, "https://dbscthumb-phinf.pstatic.net/4776_000_3/20230323160516038_46I8IFIIY.jpg/fe87_309_i1.jpg?type=m251&wm=Y"));
//	        itemrecmnd.put (7, new ItemRecommendVO (7, "청춘", 3, 2, 2, "https://dbscthumb-phinf.pstatic.net/4776_000_1/20170522192749529_XXCW7CMWA.JPG/fe87_190_i1.JPG?type=m251&wm=Y"));
//	        itemrecmnd.put (8, new ItemRecommendVO (8, "복순도가 손 막걸리", 2, 2, 3, "https://dbscthumb-phinf.pstatic.net/4776_000_1/20170113200703070_CT9LUIG2R.jpg/fe87_056_i1.jpg?type=m251&wm=Y"));
//	        itemrecmnd.put (9, new ItemRecommendVO (9, "1932새싹땅콩 햅쌀막걸리", 1, 2, 2, "https://dbscthumb-phinf.pstatic.net/4776_000_1/20170529155654649_UCG6KNQ0X.jpg/fe87_112_i1.jpg?type=m251&wm=Y"));
//	        itemrecmnd.put (10, new ItemRecommendVO (10, "1932새싹땅콩 흑미막걸리", 2, 3, 1, "https://dbscthumb-phinf.pstatic.net/4776_000_1/20170529155600621_18IACGCNU.jpg/fe87_111_i1.jpg?type=m251&wm=Y"));
//	        itemrecmnd.put (11, new ItemRecommendVO (11, "가평잣생막걸리", 3, 2, 2, "https://dbscthumb-phinf.pstatic.net/4776_000_1/20170112175112768_WMICP3MQF.jpg/fe87_008_i1.jpg?type=m251&wm=Y"));
//	        itemrecmnd.put (12, new ItemRecommendVO (12, "감사", 2, 2, 2, "https://dbscthumb-phinf.pstatic.net/4776_000_1/20170224110222108_1TLD4VYWD.jpg/fe87_080_i1.jpg?type=m251&wm=Y"));
//	        itemrecmnd.put (13, new ItemRecommendVO (13, "그랑꼬또 M56", 3, 2, 3, "https://dbscthumb-phinf.pstatic.net/4776_000_1/20170522125019915_X9OP9CNG9.jpg/fe87_125_i1.jpg?type=w492_fst_n&wm=Y"));
//	        itemrecmnd.put (14, new ItemRecommendVO (14, "그랑꼬또 로제와인", 3, 2, 3, "https://dbscthumb-phinf.pstatic.net/4776_000_1/20170522124437029_XHAF0B41O.jpg/fe87_124_i1.jpg?type=w492_fst_n&wm=Y"));
//	        itemrecmnd.put (15, new ItemRecommendVO (15, "그랑꼬또 청수 화이트와인", 3, 2, 4, "https://dbscthumb-phinf.pstatic.net/4776_000_3/20230323160232503_NO9N5EAO8.jpg/fe87_123_i1.jpg?type=w300_fst_n&wm=Y"));
//	        itemrecmnd.put (16, new ItemRecommendVO (16, "김포 막걸리", 1, 2, 2, "https://dbscthumb-phinf.pstatic.net/4776_000_1/20181013051043394_5YRGMJIQ0.jpg/fe87_305_i1.jpg?type=w300_fst_n&wm=Y"));
//	        itemrecmnd.put (17, new ItemRecommendVO (17, "김포별주", 3, 3, 1, "https://dbscthumb-phinf.pstatic.net/4776_000_1/20181013050409841_KWAXKEIH5.jpg/fe87_304_i1.jpg?type=w300_fst_n&wm=Y"));
//	        itemrecmnd.put (18, new ItemRecommendVO (18, "김포약주", 2, 1, 2, "https://dbscthumb-phinf.pstatic.net/4776_000_1/20181013045722091_SD48VR1QY.jpg/fe87_303_i1.jpg?type=w300_fst_n&wm=Y"));
//	        itemrecmnd.put (19, new ItemRecommendVO (19, "김포예주", 4, 2, 1, "https://dbscthumb-phinf.pstatic.net/4776_000_1/20181013044420009_D8C32375N.jpg/fe87_301_i1.jpg?type=w300_fst_n&wm=Y"));
//	        itemrecmnd.put (20, new ItemRecommendVO (20, "김포특주", 2, 4, 4, "https://dbscthumb-phinf.pstatic.net/4776_000_1/20181013062101632_MU0YTMOKW.jpg/fe87_315_i1.jpg?type=w300_fst_n&wm=Y"));
//	        itemrecmnd.put (21, new ItemRecommendVO (21, "느린마을 막걸리", 4, 3, 2, "https://dbscthumb-phinf.pstatic.net/4776_000_3/20230323160018342_0W66D9ADK.jpg/fe87_060_i1.jpg?type=m251&wm=Y"));
//	        itemrecmnd.put (22, new ItemRecommendVO (22, "담은", 2, 4, 2, "https://dbscthumb-phinf.pstatic.net/4776_000_3/20230323160148027_86T5CSW65.jpg/fe87_110_i1.jpg?type=w130_fst_n&wm=Y"));
//	        itemrecmnd.put (23, new ItemRecommendVO (23, "메로니아", 2, 4, 1, "https://dbscthumb-phinf.pstatic.net/4776_000_1/20170112175143396_V1UQBALSO.jpg/fe87_010_i1.jpg?type=w492_fst_n&wm=Y"));
//	        itemrecmnd.put (24, new ItemRecommendVO (24, "미생 막걸리", 3, 2, 3, "https://dbscthumb-phinf.pstatic.net/4776_000_1/20181013061306620_1KUWMGMM9.jpg/fe87_314_i1.jpg?type=w300_fst_n&wm=Y"));
//	        itemrecmnd.put (25, new ItemRecommendVO (25, "미인 약주", 2, 4, 1, "https://dbscthumb-phinf.pstatic.net/4776_000_1/20181013034743634_M48C9PA6V.jpg/fe87_293_i1.jpg?type=w300_fst_n&wm=Y"));
//	        itemrecmnd.put (26, new ItemRecommendVO (26, "붉은 원숭이", 2, 4, 2, "https://dbscthumb-phinf.pstatic.net/4776_000_1/20170112175155456_M0XP15G2K.jpg/fe87_011_i1.jpg?type=w492_fst_n&wm=Y"));
//	        itemrecmnd.put (27, new ItemRecommendVO (27, "부자막걸리", 4, 4, 1, "https://dbscthumb-phinf.pstatic.net/4776_000_1/20170112175209439_R80JW7O1W.jpg/fe87_012_i1.jpg?type=w492_fst_n&wm=Y"));
//	        itemrecmnd.put (28, new ItemRecommendVO (28, "술샘 이화주", 4, 3, 3, "https://dbscthumb-phinf.pstatic.net/4776_000_3/20230323155935055_0G9EV2D1A.jpg/fe87_007_i1.jpg?type=w340_fst_n&wm=Y"));
//	        itemrecmnd.put (29, new ItemRecommendVO (29, "술아 국화주", 4, 4, 3, "https://dbscthumb-phinf.pstatic.net/4776_000_1/20181013071307793_IYQB0A0HG.jpg/fe87_323_i1.jpg?type=w300_fst_n&wm=Y"));
//	        itemrecmnd.put (30, new ItemRecommendVO (30, "술아 막걸리", 4, 3, 4, "https://dbscthumb-phinf.pstatic.net/4776_000_1/20181013072719976_NO95M1QJO.jpg/fe87_325_i1.jpg?type=w300_fst_n&wm=Y"));
	    }
	    
	    @Override
	    public List<ItemVO> getAllItemsRecommend() {
	        // 데이터베이스에 있는 모든 아이템을 리스트로 반환
	        return new ArrayList<ItemVO>(itemrecmnd.values());
	    }

	    @Override
	    public ItemVO getItemRecommendById(int itemId) {
	        // 주어진 itemId에 해당하는 아이템 반환
	        return itemrecmnd.get(itemId);
	    }
	    
	    @Override
	    public List<ItemVO> getFilteredItems(int body, int sweet, int sour) {
	    	ItemDAO dao = new ItemDAO();
	    	
	        List<ItemVO> itemList = dao.getRecommendItems(body, sweet, sour);

	        // 사용자가 선택한 body, sweet, sour 값을 기준으로 아이템을 필터링
	        //List<ItemVO> filteredItems = new ArrayList<ItemVO>();

			/*//일단 sql문으로 알고리즘 구현해놓음
			 * // 근사치 허용 범위 설정 int tolerance = 1; // 예시로 1로 설정, 필요에 따라 조절 가능
			 * 
			 * for (ItemVO item : itemList) { // 아이템의 속성 값과 사용자가 선택한 값 간의 차이를 계산 int
			 * sweetDifference = Math.abs(item.getBody() - body); int bodyDifference =
			 * Math.abs(item.getSweet() - sweet); int neckDifference =
			 * Math.abs(item.getSour() - sour);
			 * 
			 * // 모든 차이가 허용 범위 이내일 경우 해당 아이템을 추가 if ((sweetDifference + bodyDifference +
			 * neckDifference) <= 1 ) { filteredItems.add(item); } }
			 */

	        System.out.println(itemList.size());
	        return itemList;
	    }

	}