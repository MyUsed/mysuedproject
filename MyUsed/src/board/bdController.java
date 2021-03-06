package board;

import java.util.ArrayList;
import java.util.Collections;
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

import board.QnaDTO;
import main.MainProboardDTO;
import member.MemberDTO;
import member.ProfilePicDTO;

import java.util.*;
import java.text.*; 
 

@Controller
public class bdController {

	 
	
	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
	private List<NoticeDTO> list = new ArrayList<NoticeDTO>();;
	private List<FaqDTO> list2 = new ArrayList<FaqDTO>();;
	private List<ReportDTO> list3 = new ArrayList<ReportDTO>();;
	private List<QnaDTO> list4 = new ArrayList<QnaDTO>();;
	
	@RequestMapping("board.nhn")//게시판 클릭시 이동하는 화면 컨트롤러
	public ModelAndView board(HttpSession session, ProfilePicDTO proDTO){
		String sessionId = (String) session.getAttribute("memId");
		Map picmap = new HashMap();
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMap.queryForObject("member.selectDTO", sessionId);
		picmap.put("mem_num", memDTO.getNum());
		proDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap);
		
		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy.MM.dd HH:mm:ss", Locale.KOREA );
		Date currentTime = new Date ( );
		String dTime = formatter.format ( currentTime );

		ModelAndView mv = new ModelAndView();
//
		List list = sqlMap.queryForList("notice.notice-all", null);
		int count=(int)sqlMap.queryForObject("notice.noticeCount", null);
		mv.addObject("list", list);
		mv.addObject("count", count);
		mv.addObject("name", memDTO.getName());
		mv.addObject("proDTO", proDTO);
		
//
		list2=sqlMap.queryForList("faqBd.faq-select",null);
		int count2=(int)sqlMap.queryForObject("faqBd.faqCount", null);
		mv.addObject("list2", list2);
		mv.addObject("count2", count2);
//		
		list3=sqlMap.queryForList("report.report-all",null);
		int count3=(int)sqlMap.queryForObject("report.reportCount", null);
		mv.addObject("list3", list3);
		mv.addObject("count3", count3);
//	
		list4=sqlMap.queryForList("qnaBd.select-All",null);
		int count4=(int)sqlMap.queryForObject("qnaBd.qnaCount", null);
		mv.addObject("list4", list4);
		mv.addObject("count4", count4);
//
		mv.setViewName("/board/BoardSelect.jsp");
		return mv;
	}
	@RequestMapping("SubBoard.nhn")
	public ModelAndView bd(HttpServletRequest request,String abc){
		ModelAndView mv = new ModelAndView();
		request.getParameter(abc);
		mv.addObject("abc", abc);
		mv.setViewName("/board/test.jsp");
		return mv;
	}
	@RequestMapping("Notice.nhn")
	public ModelAndView notice(HttpSession session, ProfilePicDTO proDTO){
		ModelAndView mv = new ModelAndView();
		String sessionId = (String) session.getAttribute("memId");
		Map picmap = new HashMap();
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMap.queryForObject("member.selectDTO", sessionId);
		picmap.put("mem_num", memDTO.getNum());
		proDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap);
		List list = sqlMap.queryForList("adminNotice.all", null);
		int count=(int)sqlMap.queryForObject("notice.noticeCount", null);
		mv.addObject("list", list);
		mv.addObject("count", count);
		mv.addObject("name", memDTO.getName());
		mv.addObject("proDTO", proDTO);
		mv.setViewName("/board/NoticeBoard.jsp");
		return mv;
	}
	
	@RequestMapping("Faq.nhn") 
	public ModelAndView faq(HttpServletRequest request){
		//System.out.println("category_nm="+category_id);
		ModelAndView mv = new ModelAndView();	
		list2=sqlMap.queryForList("faqBd.faq-select",null);
		int count=(int)sqlMap.queryForObject("faqBd.faqCount", null);
	    request.setAttribute("count", count);
		mv.addObject("list2", list2);
		mv.setViewName("/board/FaqBoard.jsp");
		return mv;
	}
	
	@RequestMapping("Report1.nhn")
	public ModelAndView report(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
	    String sessionId = (String) session.getAttribute("memId");
		list=sqlMap.queryForList("report.report-all",null);
		int count=(int)sqlMap.queryForObject("report.reportCount", null);
	    request.setAttribute("count", count);
		mv.addObject("list", list);
		mv.setViewName("/board/ReportBoard.jsp");
		return mv;
	}
	@RequestMapping("Reportwrite.nhn")
	public ModelAndView reportWrite(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
	    String sessionId = (String) session.getAttribute("memId");
	    mv.addObject("sessionId", sessionId);
		mv.setViewName("/board/ReportWrite.jsp");
		return mv;
	}
	@RequestMapping("Qna.nhn")
	public ModelAndView Qna(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
	    String sessionId = (String) session.getAttribute("memId");
		list=sqlMap.queryForList("qnaBd.select-All",null);
		int count=(int)sqlMap.queryForObject("qnaBd.qnaCount", null);
	    request.setAttribute("count", count);
		mv.addObject("list", list);
		mv.setViewName("/board/QnaBoard.jsp");
		return mv;
	}
	
	
	
	@RequestMapping("QnaSearch.nhn")
	public ModelAndView qnaSearch(String gubun, String search){
		ModelAndView mv = new ModelAndView();
		int count=(int)sqlMap.queryForObject("qnaBd.qnaCount", null);
		if(gubun.equals("2")){
			list=sqlMap.queryForList("qnaBd.id_Search",search);
		}else if(gubun.equals("1")){
			list=sqlMap.queryForList("qnaBd.contents_Search",search);
		}
		mv.addObject("count", count);
		mv.addObject("list", list);
		mv.setViewName("/board/QnaBoard.jsp");
		return mv;
	}
	
	@RequestMapping("Contents.nhn")
	public ModelAndView qnaContents(int seq_num){
		ModelAndView mv = new ModelAndView();
		sqlMap.update("qnaBd.countUpdate",seq_num);
		QnaDTO contents = new QnaDTO();
		 contents=(QnaDTO)sqlMap.queryForObject("qnaBd.contents", seq_num);
		
		int count = (int)sqlMap.queryForObject("qnaBd.replyCount",seq_num);
		List List = new ArrayList();
		list = sqlMap.queryForList("qnaBd.replylist",seq_num);
		mv.addObject("count", count); 
		mv.addObject("list",list);
		mv.addObject("contents", contents);
		mv.setViewName("/board/FaqBoard.jsp");
		return mv;
	}
	@RequestMapping("QnaModify.nhn")
	public ModelAndView qnaModify(int seq_num){
		ModelAndView mv = new ModelAndView();
		QnaDTO contents = new QnaDTO();
		 contents=(QnaDTO)sqlMap.queryForObject("qnaBd.contents", seq_num);
		
		mv.addObject("contents", contents);
		mv.setViewName("/board/QnaModify.jsp");
		return mv;
	}
	
	@RequestMapping("QnamodifyPro.nhn")
	public ModelAndView qnaModifyPro(String seq_num, String title, String contents){
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		map.put("seq_num", seq_num);
		map.put("title", title);
		map.put("contents", contents);	

		sqlMap.update("qnaBd.qnaBdUpdate",map);
		int count=(int)sqlMap.queryForObject("qnaBd.qnaCount", null);
		if(count!=0){
			list=sqlMap.queryForList("qnaBd.select-All",null);
		}else if(count==0){
			count=0;
		}
		mv.addObject("count", count);
		mv.addObject("list", list);
		mv.setViewName("/board/QnaBoard.jsp");
		return mv;
	}
	@RequestMapping("QnaWrite.nhn")
	public ModelAndView qnaWrite(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
	    String sessionId = (String) session.getAttribute("memId");
	    mv.addObject("sessionId", sessionId);
		mv.setViewName("/board/QnaWrite.jsp");
		return mv;
	}
	@RequestMapping("QnaWritePro.nhn")
	public ModelAndView qnaWritePro(String sessionId, String title, String pw, String contents){
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		map.put("sessionId", sessionId);
		map.put("title", title);
		map.put("pw", pw);
		map.put("contents", contents);
;
		sqlMap.insert("qnaBd.QnaInsert", map);
		int count=(int)sqlMap.queryForObject("qnaBd.qnaCount", null);
		if(count!=0){;
		list=sqlMap.queryForList("qnaBd.select-All",null);
		}else if(count==0){
			count=0;
		}
		mv.addObject("count", count);
	    mv.addObject("list", list);
		mv.setViewName("/board/QnaBoard.jsp");
		return mv;
	}
	@RequestMapping("QnaDelete.nhn")
	public ModelAndView qnaDelete(int seq_num){
		ModelAndView mv = new ModelAndView();
		sqlMap.delete("qnaBd.QnaDelete", seq_num);
		int count=(int)sqlMap.queryForObject("qnaBd.qnaCount", null);
		if(count!=0){
			list=sqlMap.queryForList("qnaBd.select-All",null);
		}else if(count==0){
		}
		mv.addObject("count", count);
	    mv.addObject("list", list);
		mv.setViewName("/board/QnaBoard.jsp");
		return mv;
	}
	
	@RequestMapping("QnaReply.nhn")
	public ModelAndView qnaReply(int qna_ref){
		ModelAndView mv = new ModelAndView();
		mv.addObject("qna_ref",qna_ref);
		mv.setViewName("/board/QnaReply.jsp");
		return mv;
	}
	
	@RequestMapping("QnaReplyPro.nhn")
	public ModelAndView qnaReplyPro(QnaDTO dto){
		ModelAndView mv = new ModelAndView();
		//sqlMap.update("qnaBd.QnaUpReply", dto);
		sqlMap.insert("qnaBd.QnaInReply", dto);
		mv.setViewName("/board/QnaReply.jsp");
		return mv;
	}
}
