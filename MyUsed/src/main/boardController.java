package main;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class boardController {
	
	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 
	
	@RequestMapping("/mainTest.nhn")
	public String mainSubmit(MultipartHttpServletRequest request , MainboardDTO dto){
	
		request.setAttribute("sendPay", dto.getSendPay());
		request.setAttribute("price", dto.getPrice());
		request.setAttribute("categ", dto.getCateg());
		String content = dto.getContent().replaceAll("\r\n","<br>"); // textarea���� ���� ó�� ; 
		request.setAttribute("content", content);	
		
		 // << ������ ���̵� �� num �������� >> 
		HttpSession session = request.getSession();
		String sessionId = (String)session.getAttribute("memId");
		System.out.println("����ID = "+sessionId);
		int num = (int)sqlMap.queryForObject("main.num", sessionId);
		String name = (String)sqlMap.queryForObject("main.name", sessionId);
		System.out.println("�������� num = "+num);
		System.out.println("�������� name = "+name);
		
		
		
		Map map = new HashMap();
		map.put("num", num);
		map.put("content",dto.getContent());
		map.put("name", name);
		
		
		// <<  num �����޾�  insert >>
		if(request.getFile("image1").isEmpty()){
			sqlMap.insert("main.addContent", map);
			System.out.println("�Ϲ� �Խñ� ��ϼ���");
			sqlMap.insert("main.addTotalContent", map);
			System.out.println("��Ż �Խñ� ��ϼ���");
		}

	for(int i=1;i<=8;i++){

	MultipartFile mf = request.getFile("image"+i); // ������ �޴� MultipartFile Ŭ����  (����)
	if(!mf.isEmpty()){		// mf�� ������ ������ Ȯ�� ���� ������ ���ε� ���� 
	String orgName = mf.getOriginalFilename(); 
	File copy = new File("E:\\Jsp Example\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MyUsed\\images\\"+ orgName); // ���ε�
	System.out.println("���ε强��");
	
	System.out.println(orgName);
	System.out.println(copy);
	
	
	request.setAttribute("orgName"+i, orgName);
	request.setAttribute("copy", copy);
	
	
	try{
		mf.transferTo(copy);	// ���ε� 
	}catch(Exception e){
		e.printStackTrace();
	}
	
	}

	}
	

		return "/main/test.jsp";
	}

}