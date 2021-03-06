package mypage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import friend.FriendCategDTO;
import friend.FriendDTO;
import member.CoverPicDTO;
import member.MemberDTO;
import member.ProfilePicDTO;

@Controller
public class MyFriendController {
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	private MemberDTO memDTO = new MemberDTO();
	private ProfilePicDTO proDTO = new ProfilePicDTO();
	private ProfilePicDTO sessionproDTO = new ProfilePicDTO();
	private CoverPicDTO coverDTO = new CoverPicDTO();
	private CoverPicDTO sessionCoverDTO = new CoverPicDTO();
	private FriendDTO friDTO = new FriendDTO();
	
	
	@RequestMapping("/MyPageBottom_friend.nhn")
	public String MyFriend(HttpServletRequest request, int mem_num){
		
		/** 로그인한 사용자의 이름 가져오기(세션아이디 이용) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);

		MemberDTO frimemDTO = new MemberDTO();
		System.out.println("mem_num : "+mem_num);
		frimemDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTOforNum", mem_num);
		
		
		//친구 목록 리스트 가져가기(state별로)
		Map map = new HashMap();
		map.put("num", memDTO.getNum());
		
		
		List friendList = new ArrayList();
		friendList = sqlMapClientTemplate.queryForList("friend.allFriend", map);

		List friendState0 = new ArrayList();
		friendState0 = sqlMapClientTemplate.queryForList("friend.friendState0", map);

		List friendState1 = new ArrayList();
		friendState1 = sqlMapClientTemplate.queryForList("friend.friendState1", map);
		
		List friendState2 = new ArrayList();
		friendState2 = sqlMapClientTemplate.queryForList("friend.friendState2", map);
		
		List friendState_m1 = new ArrayList();
		friendState_m1 = sqlMapClientTemplate.queryForList("friend.friendState_m1", map);
		
		/** 친구 카테고리 */
		FriendCategDTO fricagDTO = new FriendCategDTO();
	    List friendCateg = new ArrayList();
	    friendCateg = sqlMapClientTemplate.queryForList("friend.friendCateg", null);
	    

		/** 프로필 사진 */
		// 해당 페이지 주인의 프로필사진
		Map profileMap = new HashMap();
		profileMap.put("mem_num", mem_num);
		proDTO = (ProfilePicDTO) sqlMapClientTemplate.queryForObject("profile.newpic", profileMap);
		
		// 세션 아이디의 프로필사진
		Map profileMap2 = new HashMap();
		profileMap2.put("mem_num", memDTO.getNum());
		sessionproDTO = (ProfilePicDTO) sqlMapClientTemplate.queryForObject("profile.newpic", profileMap2);
		
		
		/** 커버 사진 */
		// 해당 페이지 주인의 커버사진
		Map coverMap = new HashMap();
		coverMap.put("mem_num", mem_num);
		coverDTO =  (CoverPicDTO) sqlMapClientTemplate.queryForObject("profile.newCoverpic", coverMap);
		

		/** 프로필 사진 뽑아오기(세션아이디 아님) -> 프로필 사진 히스토리 */
		Map hisMap = new HashMap();
		hisMap.put("mem_num", mem_num);
		List prohisList = new ArrayList();
		prohisList = sqlMapClientTemplate.queryForList("profile.prohistory",hisMap);
		
		
		/** 커버 사진 뽑아오기(세션아이디 아님) -> 커버 사진 히스토리 */
		Map cohisrMap = new HashMap();
		cohisrMap.put("mem_num", mem_num);
		List coverhisList = new ArrayList();
		coverhisList = sqlMapClientTemplate.queryForList("profile.coverhistory",hisMap);
		
		
		
		/***** 알 수 도 있는 친구*****/
		String sql = "";
		
		Map num_map = new HashMap();
		num_map.put("num", mem_num);
		
		List friNumList = new ArrayList();
		friNumList = sqlMapClientTemplate.queryForList("friend.friendNumList", num_map);
		int size = friNumList.size();
		System.out.println(size);
		
		// 친구의 수가 0보다 클때만
		if(size > 0){
			// 유니언을 하여 테이블을 이어붙인다 -> mem_num의 친구수만큼 반복(마지막줄은 union이 붙으면 안됨으로 따로 붙여줌)
			for(int i = 0 ; i < friNumList.size()-1 ; i++){
				sql += "select * from friendlist_"+friNumList.get(i)+" union ";
			}
			sql = sql + "select * from friendlist_"+friNumList.get(size-1);
			
			System.out.println(sql);

			// 이어붙인 sql문의 일부를 Map을 이용해 sqlMap으로 가져간다
			Map sqlmap = new HashMap();
			sqlmap.put("sql", sql);
			
			// mem_num의 친구리스트(빈도순 정렬)
			List knewFriendList = new ArrayList();
			knewFriendList = sqlMapClientTemplate.queryForList("friend.all", sqlmap);

			// 리스트에 자기자신이 포함되어 있을 수 도 있으므로 찾아서 삭제해준다
			FriendDTO friDTO = new FriendDTO();
			for (int i = 0; i < knewFriendList.size() ; i++){
				if(mem_num == ((FriendDTO) knewFriendList.get(i)).getMem_num()){
					knewFriendList.remove(i);
				}
			}
			
			// 리스트에 이미 친구로 등록된 친구가 추천되어있을 수 있으므로 찾아서 삭제해준다.
			for(int i = 0; i < friendList.size() ; i++){
				for(int j = 0; j < knewFriendList.size() ; j++){
					// 모든 친구 리스트가 뽑힌 friendList와 자기 자신을 제거한 knewFriendList를 비교해서 동일한 mem_num이 있나 찾는다
					if(((FriendDTO) friendList.get(i)).getMem_num() == ((FriendDTO) knewFriendList.get(j)).getMem_num()){
						// 만약 있다면 knewFriendList에서 지워준다.
						knewFriendList.remove(j);
					}
				}
			}
			
			/** 알 수 도 있는 친구들의 프로필 사진 */
			int friend_num;
			Map friend_numMap = new HashMap();
			List knewFriendList_image = new ArrayList();
			for (int i = 0; i < knewFriendList.size() ; i++){
				friend_num = ((FriendDTO) knewFriendList.get(i)).getMem_num();
				
				friend_numMap.put("mem_num", friend_num);

				ProfilePicDTO friproDTO = new ProfilePicDTO();
				friproDTO = (ProfilePicDTO) sqlMapClientTemplate.queryForObject("profile.newpic", friend_numMap);

				knewFriendList_image.add(i, friproDTO);
			}

			for (int i = 0; i < knewFriendList_image.size() ; i++){
				//System.out.println(knewFriendList_image.get(i));
				System.out.println(((ProfilePicDTO)knewFriendList_image.get(i)).getProfile_pic());
			}

			request.setAttribute("knewFriendList_image", knewFriendList_image);
			request.setAttribute("knewFriendList", knewFriendList);
			
		}
		
		/** 친구목록  + 친구들의 프로필 사진  리스트
		 * 1. 친구리스트에서 친구의 num를 찾아 리스트에 담는다
		 * 2. 친구의 num을 이용해 해당 친구의 현재 프로필 사진을 찾는다(프로필 사진 테이블의 가장 최근 레코드) 
		 * 3. 친구의 현재 프로필 사진이 들어있는 레코드들을 union을 이용하여 이어붙인다.
		 * 4. 이어붙인 테이블과 친구리스트와 조인하여 출력한다.
		 * */
		String friendpic_sql = "";
		
		for(int i = 0 ; i < friendState2.size() ; i++){
			System.out.println(friendState2.size());
		}
		
		// 친구목록이 0보다 클때
		if(friendState2.size() > 0){
			// 유니언을 하여 테이블을 이어붙인다 -> mem_num의 친구수만큼 반복(마지막줄은 union이 붙으면 안됨으로 따로붙여줌)
			for (int i = 0; i < friendState2.size() - 1; i++) {
				friendpic_sql += "select * from profilepic_" + ((FriendDTO)friendState2.get(i)).getMem_num() + " where pic_num = (select max(pic_num) from profilepic_" + ((FriendDTO)friendState2.get(i)).getMem_num() + ") union ";
			}
			friendpic_sql += "select * from profilepic_" + ((FriendDTO)friendState2.get(friendState2.size()-1)).getMem_num() + " where pic_num = (select max(pic_num) from profilepic_" + ((FriendDTO)friendState2.get(friendState2.size()-1)).getMem_num() + ")";
			
			System.out.println(friendpic_sql);
			
			Map frisqlMap = new HashMap();
			frisqlMap.put("friendpic_sql", friendpic_sql);
			frisqlMap.put("num", mem_num);	//세션 아이디의 mem_num아님 / 현재 페이지의 mem_num
			System.out.println(frisqlMap);
			
			// 현재 페이지의 친구목록+프로필사진
			List friendpicList = new ArrayList();
			friendpicList = sqlMapClientTemplate.queryForList("friend.friendproPic", frisqlMap);
			
			for(int i = 0 ; i < friendpicList.size() ; i++){
				System.out.println(((FriendDTO)friendpicList.get(i)).getProfile_pic());
			}
			
			request.setAttribute("friendpicList", friendpicList);
		}
		
		

		request.setAttribute("coverhisList", coverhisList);
		request.setAttribute("prohisList", prohisList);
		request.setAttribute("mem_num", mem_num); // 세션아이디의 mem_num 아님/ 현재 페이지의 mem_num
		request.setAttribute("proDTO", proDTO);
		request.setAttribute("coverDTO", coverDTO);
		request.setAttribute("sessionCoverDTO", sessionCoverDTO);
		request.setAttribute("sessionproDTO", sessionproDTO);
		request.setAttribute("sessionName", memDTO.getName());
		request.setAttribute("name", frimemDTO.getName());
		request.setAttribute("num", frimemDTO.getNum());
		request.setAttribute("mynum", memDTO.getNum());	// 세션아이디의 mem_num
		request.setAttribute("friendList", friendList);
		request.setAttribute("friendState0", friendState0);
		request.setAttribute("friendState1", friendState1);
		request.setAttribute("friendState2", friendState2);
		request.setAttribute("friendState_m1", friendState_m1);
	    request.setAttribute("friendCateg", friendCateg);
		
		return "/mypage/MyPageBottom_friend.jsp";
	}
	
	/* 친구등록 새창 띄워서 */
	@RequestMapping("/AddFriend.nhn")
	public String addFriend(HttpServletRequest request, int mem_num){

		/** 등록하려는 친구의 정보 */
		MemberDTO frimemDTO = new MemberDTO();
		frimemDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTOforNum", mem_num);

		/** 친구 카테고리 */
		FriendCategDTO fricagDTO = new FriendCategDTO();
		List friendCateg = new ArrayList();
		friendCateg = sqlMapClientTemplate.queryForList("friend.friendCateg", null);
	
		System.out.println(mem_num);
		
		request.setAttribute("mem_num", mem_num);
		request.setAttribute("frimemDTO", frimemDTO);
		request.setAttribute("friendCateg", friendCateg);
		
		return "/friend/addFriendNewWin.jsp";
	}
	
	@RequestMapping("/AddFriendPro.nhn")
	public String addFriendPro(HttpServletRequest request, int mem_num, String categ){
		/** 로그인한 사용자의 정보 가져오기(세션아이디 이용) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);

		/** 등록하려는 친구의 정보 */
		MemberDTO frimemDTO = new MemberDTO();
		frimemDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTOforNum", mem_num);

		/** 나의 친구리스트에 친구의 정보를 추가 */
		Map map1 = new HashMap();
		map1.put("num", memDTO.getNum());	// 나의 num(테이블 찾기위해)
		map1.put("mem_num", mem_num);	// 친구신청 받는 사람의 num
		map1.put("id", frimemDTO.getId());
		map1.put("name", frimemDTO.getName());
		map1.put("state", "0");
		map1.put("categ", categ);
		
		System.out.println(map1);
		
		sqlMapClientTemplate.insert("friend.addFriend", map1);
		

		/** 친구신청 받는 사람의 친구리스트에 나의 정보를 추가 */
		Map map2 = new HashMap();
		map2.put("num", frimemDTO.getNum());	// 상대방의 num(테이블 찾기위해)
		map2.put("mem_num", memDTO.getNum());	// 나의 num
		map2.put("id", sessionId);
		map2.put("name", memDTO.getName());
		map2.put("state", "1");
		map2.put("categ", categ);
		
		System.out.println(map2);
		
		sqlMapClientTemplate.insert("friend.addFriend", map2);

		
		request.setAttribute("mem_num", mem_num);
		request.setAttribute("frimemDTO", frimemDTO);
		
		return "/friend/addFriendNewWinPro.jsp";
	}

}
