package paper;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import admin.BannerApplyDTO;
import member.MemberDTO;
import member.ProfilePicDTO;

@Controller
public class PaperController {
	@Autowired
	private SqlMapClientTemplate SqlMapClientTemplate;

	@RequestMapping("paperMain.nhn")	// 쪽지 보여주는 메인
	public ModelAndView paperMain(int mynum, HttpServletRequest request, ProfilePicDTO proDTO, HttpSession session){
		Map map = new HashMap();
		map.put("mem_num", mynum);
		proDTO = (ProfilePicDTO) SqlMapClientTemplate.queryForObject("profile.newpic", map); // 프로필
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) SqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);

		request.setAttribute("name", memDTO.getName());

		String pagecurrent = request.getParameter("currentPage");	// 현재페이지의 parameter값을 담는 변수
		int currentPage = 1;	// 현재페이지
		int totalCount = 0;		// 전체 게시글 수
		int blockCount = 10;	// 한 페이지 게시글 수
		int blockPage = 5;		// 5페이지까지 생성되면 6부터 다시생 성
		int lastCount = 0;		// 페이지 마다 끝 게시글
		String pagingHtml;
		
		if(pagecurrent != null){	// 현재페이지 parameter를 담은 변수가 null이 아니면
			currentPage = Integer.parseInt(pagecurrent);	// 현재페이지에 대입
		}
		else{	
			currentPage = 1;	// 현재페이지가 null이면 1
		}
		
		ModelAndView mv = new ModelAndView();
		map.put("mynum", mynum);	// 회원 고유 번호
		List list = SqlMapClientTemplate.queryForList("paper.all", map); // 쪽지테이블 내용 다가져오기

		totalCount = list.size();	// list의 사이즈만큼 totalCount에 대입
		pagingAction page = new pagingAction(currentPage, totalCount, blockCount, blockPage, mynum);
		pagingHtml = page.getPagingHtml().toString();	// 문자로 변환
		lastCount = totalCount;	
		
		if (page.getEndCount() < totalCount)
			lastCount = page.getEndCount() + 1;
		
		 list = list.subList(page.getStartCount(), lastCount);
		 
		
		int paperCount = (int)SqlMapClientTemplate.queryForObject("paper.paperCount", map);	// 글 읽음 여부. state값 가져오기
		
		// 광고 가져옴 
		BannerApplyDTO banner = new BannerApplyDTO();
		banner = (BannerApplyDTO)SqlMapClientTemplate.queryForObject("main.bannerSelect",null);
		
		mv.addObject("list", list);
		mv.addObject("mynum", mynum);
		mv.addObject("proDTO", proDTO);
		mv.addObject("memDTO", memDTO);
		mv.addObject("pagingHtml", pagingHtml);
		mv.addObject("paperCount", paperCount);
		mv.addObject("banner",banner);
		mv.setViewName("/paper/paperMain.jsp");
		return mv;
	}
	
	@RequestMapping("paperForm.nhn")	// 쪽지 쓰는 폼
	public ModelAndView paperForm(int mynum, String name, HttpSession session, ProfilePicDTO proDTO){
		Map map = new HashMap();
		map.put("mem_num", mynum);
		proDTO = (ProfilePicDTO) SqlMapClientTemplate.queryForObject("profile.newpic", map); // 프로필
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) SqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		
		// 광고 가져옴 
		BannerApplyDTO banner = new BannerApplyDTO();
		banner = (BannerApplyDTO)SqlMapClientTemplate.queryForObject("main.bannerSelect",null);

		ModelAndView mv = new ModelAndView();
		mv.addObject("proDTO", proDTO);
		mv.addObject("memDTO", memDTO);
		mv.addObject("mynum", mynum);
		mv.addObject("name", name);
		mv.addObject("banner",banner);
		mv.setViewName("/paper/paperForm.jsp");
		return mv;
	}
	
	@RequestMapping("paperchatForm.nhn")	// 쪽지 쓰는 폼
	public ModelAndView paperchatForm(int mynum, String name, HttpSession session, ProfilePicDTO proDTO){
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		map.put("mem_num", mynum);
		proDTO = (ProfilePicDTO) SqlMapClientTemplate.queryForObject("profile.newpic", map); // 프로필
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) SqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		// 광고 가져옴 
		BannerApplyDTO banner = new BannerApplyDTO();
		banner = (BannerApplyDTO)SqlMapClientTemplate.queryForObject("main.bannerSelect",null);
		mv.addObject("proDTO", proDTO);
		mv.addObject("memDTO", memDTO);
		mv.addObject("banner",banner);
		mv.addObject("mynum", mynum);
		mv.addObject("name", name);
		mv.setViewName("/paper/paperchatForm.jsp");
		return mv;
	}
	
	@RequestMapping("paperSend.nhn")	// 쪽지 보냈을 때
	public ModelAndView paperSend(PaperDTO dto, int mynum, String r_content, String r_name, HttpSession session){
		ModelAndView mv = new ModelAndView();

		Map map = new HashMap();
			String sessionId = (String)session.getAttribute("memId");
			map.put("mynum", mynum);	// 쪽지 보낸 회원 고유 번호
			map.put("r_id", r_name);	// 쪽지 받을 회원 id
			int memNum = (int)SqlMapClientTemplate.queryForObject("paper.memberNum", map);	//DB에 insert될 회원 고유 번호 찾기
			map.put("memNum", memNum);	// 쪽지 받을 회원 고유 번호
			map.put("s_content", r_content);	// 받을 쪽지 내용
			map.put("s_name", sessionId);	// 보낸 사람 아이디
			SqlMapClientTemplate.insert("paper.send", map);	// 쪽지 받을 회원 DB에 insert
			SqlMapClientTemplate.insert("paper.sendCollection", map);	// 보낸쪽지함 DB에 insert
			map.put("board_num",mynum);
			map.put("categ", "msg");
			map.put("state", 1);
			
			String name = (String)SqlMapClientTemplate.queryForObject("paper.SerachName",mynum);
			
			map.put("name",name);
			SqlMapClientTemplate.insert("paper.insertNoticeMsg",map); // 알림 테이블에 값 삽입;
			
			// 광고 가져옴 
			BannerApplyDTO banner = new BannerApplyDTO();
			banner = (BannerApplyDTO)SqlMapClientTemplate.queryForObject("main.bannerSelect",null);
			
		mv.addObject("mynum", mynum);
		mv.addObject("banner",banner);
		mv.setViewName("/paper/paperSend.jsp");
		return mv;
	}
	
	@RequestMapping("paperchatSend.nhn")	// 쪽지 보냈을 때
	public ModelAndView paperchatSend(PaperDTO dto, int mynum, String r_content, String r_name, HttpSession session){
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
			String sessionId = (String)session.getAttribute("memId");
			map.put("mynum", mynum);	// 쪽지 보낸 회원 고유 번호
			map.put("r_id", r_name);	// 쪽지 받을 회원 id
			int memNum = (int)SqlMapClientTemplate.queryForObject("paper.memberNum", map);	//DB에 insert될 회원 고유 번호 찾기
			map.put("memNum", memNum);	// 쪽지 받을 회원 고유 번호
			map.put("s_content", r_content);	// 받을 쪽지 내용
			map.put("s_name", sessionId);	// 보낸 사람 아이디
			SqlMapClientTemplate.insert("paper.send", map);	// 쪽지 받을 회원 DB에 insert
			SqlMapClientTemplate.insert("paper.sendCollection", map);	// 보낸쪽지함 DB에 insert
		mv.addObject("mynum", mynum);
		mv.setViewName("/paper/paperchatSend.jsp");
		return mv;
	}
	
	@RequestMapping("paperDelete.nhn")	// 전체 및 낱개 쪽지 삭제
	public ModelAndView paperDelete(int check[], int mynum){
		Map map = new HashMap();
		for (int i = 0; i < check.length; i++) {	//check된 개수 만큼 동작
			map.put("m_no", check[i]);	// 글번호(check[i])를  m_no로 map에 넣어줌
			map.put("mynum", mynum);
			SqlMapClientTemplate.delete("paper.delete", map);	// 쪽지 삭제
		}
		ModelAndView mv = new ModelAndView();
		mv.addObject("mynum", mynum);
		mv.setViewName("/paper/paperDelete.jsp");
		return mv;
	}
	
	@RequestMapping("paperView.nhn")	// 쪽지 내용 보기
	public ModelAndView paperView(PaperDTO dto, int m_no, HttpSession session){
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		String sessionId = (String)session.getAttribute("memId");
		map.put("r_id", sessionId);	// sessionId
		int mynum = (int)SqlMapClientTemplate.queryForObject("paper.memberNum", map);	// 회원 고유 번호 가져오기
		map.put("mynum", mynum);	// 회원 고유 번호
		map.put("m_no", m_no);		// 쪽지 글 번호
		
		dto = (PaperDTO)SqlMapClientTemplate.queryForObject("paper.memAll", map);	// 쪽지 내용 1개 가져오기
		int stateCount = (int)SqlMapClientTemplate.queryForObject("paper.stateCount", map);	// 글 읽음 여부. state값 가져오기
		
		if(stateCount == 1){	// 글을 읽은상태(1)이면 0으로 바꿔줌
			SqlMapClientTemplate.update("paper.state", map);	// 글을 읽으면 state를 0으로 바꿔줌.
		}
		
		String memname = dto.getS_name();	// memberlist에서 이름을 꺼내기위해 사용할 변수
		String name = (String)SqlMapClientTemplate.queryForObject("paper.name", memname);	// memberlist에서 사용자 이름 가져오기
		
		// 광고 가져옴 
		BannerApplyDTO banner = new BannerApplyDTO();
		banner = (BannerApplyDTO)SqlMapClientTemplate.queryForObject("main.bannerSelect",null);
				
		
		mv.addObject("banner",banner);
		mv.addObject("dto", dto);
		mv.addObject("mynum", mynum);
		mv.addObject("m_no", m_no);
		mv.addObject("name", name);
		mv.setViewName("/paper/paperView.jsp");
		return mv;
		
	}
	
	@RequestMapping("paperViewDelete.nhn")	// 뷰에서 쪽지 삭제
	public ModelAndView paperViewDelete(int mynum, int m_no){
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		map.put("mynum", mynum);
		map.put("m_no", m_no);
		SqlMapClientTemplate.delete("paper.delete", map);
		mv.addObject("mynum", mynum);
		mv.setViewName("/paper/paperDelete.jsp");
		return mv;
	}
	
	@RequestMapping("paperFriendList.nhn")	// 친구목록
	public ModelAndView paperFriendList(int mynum){
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		map.put("mynum", mynum);
		List list = SqlMapClientTemplate.queryForList("paper.FriendId", map);
		mv.addObject("list", list);
		mv.setViewName("/paper/paperFriendList.jsp");
		return mv;
	}
	
	@RequestMapping("paperCollection.nhn")	// 보낸 쪽지함
	public ModelAndView paperCollection(int mynum, HttpServletRequest request, HttpSession session, ProfilePicDTO proDTO){
		Map map = new HashMap();
		map.put("mem_num", mynum);
		proDTO = (ProfilePicDTO) SqlMapClientTemplate.queryForObject("profile.newpic", map); // 프로필
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) SqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);

		request.setAttribute("name", memDTO.getName());

		ModelAndView mv = new ModelAndView();
		
		String pagecurrent = request.getParameter("currentPage");	// 현재페이지의 parameter값을 담는 변수
		int currentPage = 1;	// 현재페이지
		int totalCount = 0;		// 전체 게시글 수
		int blockCount = 10;	// 한 페이지 게시글 수
		int blockPage = 5;		// 5페이지까지 생성되면 6부터 다시생 성
		int lastCount = 0;		// 페이지 마다 끝 게시글
		String pagingHtml;
		
		if(pagecurrent != null){	// 현재페이지 parameter를 담은 변수가 null이 아니면
			currentPage = Integer.parseInt(pagecurrent);	// 현재페이지에 대입
		}
		else{	
			currentPage = 1;	// 현재페이지가 null이면 1
		}
		
		List list = SqlMapClientTemplate.queryForList("paper.Collection", mynum);
		
		totalCount = list.size();	// list의 사이즈만큼 totalCount에 대입
		pagingRAction page = new pagingRAction(currentPage, totalCount, blockCount, blockPage, mynum);
		pagingHtml = page.getPagingHtml().toString();	// 문자로 변환
		lastCount = totalCount;	
		
		if (page.getEndCount() < totalCount)
			lastCount = page.getEndCount() + 1;
		
		 list = list.subList(page.getStartCount(), lastCount);
		 
			// 광고 가져옴 
			BannerApplyDTO banner = new BannerApplyDTO();
			banner = (BannerApplyDTO)SqlMapClientTemplate.queryForObject("main.bannerSelect",null);
			
		mv.addObject("banner",banner);
		mv.addObject("mynum", mynum);
		mv.addObject("list", list);
		mv.addObject("proDTO", proDTO);
		mv.addObject("pagingHtml", pagingHtml);
		mv.setViewName("/paper/paperCollection.jsp");
		return mv;
	}
	
		@RequestMapping("paperRView.nhn")
		public ModelAndView paperRView(int m_no, int mynum, PaperRDTO rdto){
			ModelAndView mv = new ModelAndView();
			Map map = new HashMap();
			map.put("mynum", mynum);
			map.put("m_no", m_no);
			rdto = (PaperRDTO)SqlMapClientTemplate.queryForObject("paper.memRAll", map);
			mv.addObject("rdto", rdto);
			mv.addObject("mynum", mynum);
			mv.addObject("m_no", m_no);
			mv.setViewName("/paper/paperRView.jsp");
			return mv;
		}
		
		@RequestMapping("paperRDelete.nhn")	// 보낸 전체 및 낱개 쪽지 삭제
		public ModelAndView paperRDelete(int check[], int mynum){
			Map map = new HashMap();
			for (int i = 0; i < check.length; i++) {	//check된 개수 만큼 동작
				map.put("m_no", check[i]);	// 글번호(check[i])를  m_no로 map에 넣어줌
				map.put("mynum", mynum);
				SqlMapClientTemplate.delete("paper.Rdelete", map);	// 쪽지 삭제
			}
			ModelAndView mv = new ModelAndView();
			mv.addObject("mynum", mynum);
			mv.setViewName("/paper/paperRDelete.jsp");
			return mv;
		}
		
		@RequestMapping("paperViewRDelete.nhn")
		public ModelAndView paperViewRDelete(int mynum, int m_no){
			ModelAndView mv = new ModelAndView();
			Map map = new HashMap();
			map.put("mynum", mynum);
			map.put("m_no", m_no);
			SqlMapClientTemplate.delete("paper.Rdelete", map);
			mv.addObject("mynum", mynum);
			mv.setViewName("/paper/paperRDelete.jsp");
			return mv;
		}
		
		@RequestMapping("paperFormnew.nhn")	// 쪽지 쓰는 폼(새창)
		public ModelAndView paperFormnew(int mynum, String name){
			ModelAndView mv = new ModelAndView();
			mv.addObject("mynum", mynum);
			mv.addObject("name", name);
			mv.setViewName("/paper/paperForm_new.jsp");
			return mv;
		}
		
}
