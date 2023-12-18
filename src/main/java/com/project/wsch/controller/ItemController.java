package com.project.wsch.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.wsch.service.ItemRecommendService;
import com.project.wsch.service.ItemService;
import com.project.wsch.vo.ItemDAO;
import com.project.wsch.vo.ItemRecommendVO;
import com.project.wsch.vo.ItemVO;
import com.project.wsch.vo.WishListVO;

@Controller
@RequestMapping("/items")
public class ItemController {

    @Autowired
    private ItemService itemService;
    
    @Autowired
    private ItemRecommendService itemrservice;
    
	ItemDAO dao = new ItemDAO(); 	
    
    @GetMapping("/list")
    public String itemList(Model model, HttpServletRequest request, HttpSession session) {
    	String userid = (String)session.getAttribute("logId");

    	List<ItemVO> items = dao.getAllItems();
    	List<ItemVO> searchItems;
    	if(userid != null) {
    		List<WishListVO> wishList = dao.getAllWish(userid);
        	model.addAttribute("wishList", wishList);

    	}
    	


        int currentPage = 1; // 현재 페이지 인덱스, 초기값 1
        int pageSize = 3; // 한 페이지에 표시할 아이템 갯수, 테스트용 임시 값 2 넣어둠
        String type = null;
        String searchKeyword = null;
        int searchOption = 1;
        
        // 쿼리스트링으로 받은 값이 있을경우, 그 값들로 바꿔주기
        // 페이지 선택시
        if(request.getParameter("page") != null) {
        	currentPage = Integer.parseInt((request.getParameter("page")));
        }
        // 술 카테고리 선택시
        if(request.getParameter("type") != null) {
        	type = request.getParameter("type");
        }
        // 검색어가 있을 경우 검색어로 찾은 리스트도 보내준다.
        if(request.getParameter("searchKeyword") != null) {
        	searchKeyword = request.getParameter("searchKeyword");
        	searchOption = Integer.parseInt(request.getParameter("searchOption"));
        	searchItems = dao.getItemsBySearchKeyword(searchKeyword, searchOption);
        	
        	model.addAttribute("searchItems", searchItems);
        }
  
        
    	model.addAttribute("items", items);
    	model.addAttribute("searchKeyword",searchKeyword);
    	model.addAttribute("type",type);
    	model.addAttribute("currentPage",currentPage);
    	model.addAttribute("searchOption",searchOption);

    	
        return "/items/itemList";
    }

    @GetMapping("/detail/{itemNo}")
    public String itemDetail(@PathVariable int itemNo, Model model, HttpSession session) {
    	String userid = (String)session.getAttribute("logId");

    	List<ItemVO> bestList = dao.getBestItems();
    	WishListVO wishvo = dao.getWishById(itemNo, userid);
        ItemVO item = dao.getItemById(itemNo);
        
        model.addAttribute("item", item);
		model.addAttribute("bestList", bestList);
		model.addAttribute("wishvo",wishvo);

        return "/items/detail";
    }
    
    @GetMapping("/recmnd")
    public String recmnd() {    	
    	return "items/recmnd";
    }

    @GetMapping("/recmnd/result")
    @ResponseBody
    public void recmndResult(@RequestParam("body") int body, @RequestParam("sweet") int sweet, @RequestParam("sour") int sour, HttpServletResponse response) {
        //System.out.println(body + ", " + sweet + ", " + sour); //콘솔 테스트용 
    	
        JSONArray jArray = new JSONArray();
        
        List<ItemVO> filteredItems = itemrservice.getFilteredItems(body, sweet, sour);
        //System.out.println(filteredItems.get(1).getName()); //콘솔 테스트용 

      //가장 추천도 높은 데이터 6개 보내기
        try {
        	//
        	for(int i=0;i<6;i++) {
        		JSONObject data = new JSONObject();
        		data.put("id", filteredItems.get(i).getId());
        		data.put("name", filteredItems.get(i).getName());
        		data.put("img_prod", filteredItems.get(i).getImg_prod());
        		
        		jArray.put(data);
        	}
            response.getWriter().print(jArray);
        } catch (Exception e) {
        	e.printStackTrace();
		}
        
        //System.out.println("jsonArray:"+jArray);
        
    }
    
    @PostMapping("/detail/wish")
    @ResponseBody
    public int wish(@RequestParam("id") int id, @RequestParam("wish") String wish, HttpSession session) {
    	int result = 0;
    	//로그인이 안되어있을때
    	if(!(((String)session.getAttribute("logStatus")).equals("Y"))) {
    		return result;
    	}
    	
    	String userid = (String)session.getAttribute("logId");
    	if(wish.equals("on")) {
    		result = dao.deleteWish(id, userid);
    	}else {
    		result = dao.insertWish(id, userid);
    	}
    	return result;
    }
    
    
}