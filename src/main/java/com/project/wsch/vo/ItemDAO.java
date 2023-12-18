package com.project.wsch.vo;

import java.util.ArrayList;
import java.util.List;

public class ItemDAO extends DBConnection{
	public List<ItemVO> getAllItems() {
		List<ItemVO> list = new ArrayList<ItemVO>();
		try {
			dbConnection();
			
			String sql = "SELECT * FROM items";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ItemVO vo = new ItemVO();
				vo.setId(rs.getInt(1));
				vo.setName(rs.getString(2));
				vo.setType(rs.getString(3));
				vo.setAbv(rs.getString(4));
				vo.setAmount(rs.getString(5));
				vo.setPrice(rs.getString(6));
				vo.setMaterials(rs.getString(7));
				vo.setImg_prod(rs.getString(8));
				vo.setImg_taste(rs.getString(9));
				vo.setDesc(rs.getString(10));
				vo.setBody(rs.getInt(11));
				vo.setSweet(rs.getInt(12));
				vo.setSour(rs.getInt(13));

				list.add(vo);
			}
			
		} catch(Exception e){
			e.printStackTrace();
		} finally {
			dbClose();
		}
		
		return list;
	}
	
	public ItemVO getItemById(int id) {
		ItemVO vo = new ItemVO();
		
		try {
			dbConnection();
			
			String sql = "SELECT * FROM items WHERE id=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo.setId(rs.getInt(1));
				vo.setName(rs.getString(2));
				vo.setType(rs.getString(3));
				vo.setAbv(rs.getString(4));
				vo.setAmount(rs.getString(5));
				vo.setPrice(rs.getString(6));
				vo.setMaterials(rs.getString(7));
				vo.setImg_prod(rs.getString(8));
				vo.setImg_taste(rs.getString(9));
				vo.setDesc(rs.getString(10));
				vo.setBody(rs.getInt(11));
				vo.setSweet(rs.getInt(12));
				vo.setSour(rs.getInt(13));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbClose();
		}
		
		return vo;
	}
	
	public List<ItemVO> getItemsBySearchKeyword(String keyword, int searchOption) {
		List<ItemVO> list = new ArrayList<ItemVO>();
		try {
			dbConnection();
			
			String sql = "";
			
			if(searchOption == 1) {
				// 이름으로 검색
				sql = "SELECT * FROM items WHERE name LIKE '%"+keyword+"%'";//keyword가 포함되면
			}else if(searchOption == 2) {
				// 이름 외 특징으로 검색
				sql = "SELECT * FROM items WHERE desc LIKE '%"+keyword+"%'";//keyword가 포함되면
			}
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ItemVO vo = new ItemVO();
				vo.setId(rs.getInt(1));
				vo.setName(rs.getString(2));
				vo.setType(rs.getString(3));
				vo.setAbv(rs.getString(4));
				vo.setAmount(rs.getString(5));
				vo.setPrice(rs.getString(6));
				vo.setMaterials(rs.getString(7));
				vo.setImg_prod(rs.getString(8));
				vo.setImg_taste(rs.getString(9));
				vo.setDesc(rs.getString(10));
				vo.setBody(rs.getInt(11));
				vo.setSweet(rs.getInt(12));
				vo.setSour(rs.getInt(13));
			
				list.add(vo);
			}
			
		} catch(Exception e){
			e.printStackTrace();
		} finally {
			dbClose();
		}
		
		return list;
	}
	
	public List<ItemVO> getBestItems(){
		List<ItemVO> list = new ArrayList<ItemVO>();

		try {
			dbConnection();
			
			String sql = "SELECT i.id, i.name, i.type, i.abv, i.amount, i.price, i.materials, i.img_prod, i.img_taste, i.desc FROM items i JOIN( SELECT w.id, COUNT(w.id) AS wish_count FROM wishlist w group by w.id ) wc on i.id = wc.id order by wc.wish_count desc";	
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ItemVO vo = new ItemVO();
				vo.setId(rs.getInt(1));
				vo.setName(rs.getString(2));
				vo.setType(rs.getString(3));
				vo.setAbv(rs.getString(4));
				vo.setAmount(rs.getString(5));
				vo.setPrice(rs.getString(6));
				vo.setMaterials(rs.getString(7));
				vo.setImg_prod(rs.getString(8));
				vo.setImg_taste(rs.getString(9));
				vo.setDesc(rs.getString(10));
			
				list.add(vo);
			}
			
		} catch(Exception e){
			e.printStackTrace();
		} finally {
			dbClose();
		}
		
		return list;
	}
	
	public List<ItemVO> getRecommendItems(int body, int sweet, int sour){
		List<ItemVO> list = new ArrayList<ItemVO>();

		try {
			dbConnection();
			
			String sql = "SELECT id, name, img_prod, abs(body-?) + abs(sweet-?) + abs(sour-?) FROM items ORDER BY abs(body-?) + abs(sweet-?) + abs(sour-?) ASC";	
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, body);
			pstmt.setInt(2, sweet);
			pstmt.setInt(3, sour);
			pstmt.setInt(4, body);
			pstmt.setInt(5, sweet);
			pstmt.setInt(6, sour);

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ItemVO vo = new ItemVO();
				vo.setId(rs.getInt(1));
				vo.setName(rs.getString(2));
				vo.setImg_prod(rs.getString(3));
			
				list.add(vo);
			}
			System.out.println(list);
			
		} catch(Exception e){
			e.printStackTrace();
		} finally {
			dbClose();
		}
		
		return list;
	}
	
	
	/* wishlist */
	//위시리스트 추가
	public int insertWish(int id, String userid) {
		int cnt = 0;
		try {
			dbConnection();
			
			String sql = "INSERT INTO wishlist (id, userid) VALUES (?, ?)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.setString(2, userid);
			
			cnt = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbClose();
		}
		return cnt;
	}
	
	//위시리스트 삭제
	public int deleteWish(int id, String userid) {
		int cnt = 0;
		try {
			dbConnection();
			
			String sql = "DELETE FROM wishlist WHERE id=? AND userid=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.setString(2, userid);

			
			cnt = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbClose();
		}
		return cnt;
	}
	
	//위시리스트 모든 정보 가져오기(아이템 리스트 페이지, 마이페이지 위시리스트)
	public List<WishListVO> getAllWish(String userid){
		List<WishListVO> list = new ArrayList<WishListVO>();
		try {
			dbConnection();
			
			String sql = "SELECT id, userid FROM wishlist WHERE userid=? ORDER BY time DESC";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userid);

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				WishListVO vo = new WishListVO();
				vo.setId(rs.getInt(1));
				vo.setUserid(rs.getString(2));
				list.add(vo);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbClose();
		}
		return list;
	}
	
	//위시리스트 아이템 한개의 정보 가져오기(아이템 데테일 페이지)
	public WishListVO getWishById(int id, String userid) {
		WishListVO vo = new WishListVO();
		try {
			dbConnection();
			
			String sql = "SELECT * FROM wishlist WHERE id=? AND userid=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.setString(2, userid);

			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo.setId(rs.getInt(1));
				vo.setUserid(rs.getString(2));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbClose();
		}
		return vo;
	}
}
