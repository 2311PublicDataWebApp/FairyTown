package com.fairytown.ft.qna.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.GoodsVO;
import com.fairytown.ft.qna.domain.vo.QnaVO;
import com.fairytown.ft.qna.service.QnaService;
import com.fairytown.ft.user.controller.UserController;
import com.fairytown.ft.user.domain.vo.UserVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class QnaController {
	
	@Autowired
	UserController User;
	
	@Autowired
	private QnaService qService;
	
	@GetMapping("/qna/adminList.ft")
    public ModelAndView ShowAdminQnaList(ModelAndView mv,
            @RequestParam(value="page", 
            required=false, defaultValue="1") Integer currentPage) {
		try {
			int totalCount = qService.getTotalCount();
			PageInfo pInfo = this.getPageInfo(currentPage, totalCount);
			List<QnaVO> qList = qService.selectQnaList(pInfo);
			mv.addObject("qList", qList);
			mv.addObject("pInfo", pInfo);
			mv.setViewName("admin/qnaadmin");
		} catch (Exception e) {
			// TODO: handle exception
			mv.addObject("msg", e.getMessage());
			mv.setViewName("common/errorPage");
		}
		return mv;
    };
	
    // 문의 추가페이지
    @GetMapping("/qna/insert.ft")
    public <User> String showInsertForm(Model model, HttpSession session) {
        // 세션에서 사용자 정보를 가져옵니다.
        User user = (User)session.getAttribute("user");
        // 모델에 사용자 정보를 추가합니다.
        model.addAttribute("user", user);
        // 문의 작성 페이지로 이동합니다.
        return "qna/register";
    }
    
    //문의 추가
    @PostMapping("/qna/insert.ft")
    public <User>ModelAndView insertqna(ModelAndView mv
            , @ModelAttribute QnaVO qna
            , HttpSession session
            , HttpServletRequest request) {
        try {
            // 세션에서 사용자 정보를 가져옵니다.
            User user = (User)session.getAttribute("user");
            // 사용자 정보를 qna 객체에 설정합니다.
            qna.setQnaWriter(((UserVO) user).getUsername()); // 또는 사용자의 다른 정보를 설정할 수 있습니다.
            
            qna.setQnaStatus("답변대기"); // 새로 추가한 필드를 설정
            int result = qService.insertQna(qna);
            if (result > 0) {
                mv.setViewName("redirect:/qna/list.ft");
            } else {
                mv.addObject("msg", "공지사항 등록이 완료되지 못했습니다.");
                mv.setViewName("common/errorPage");
            }
        } catch (Exception e) {
            mv.addObject("msg", e.getMessage());
            mv.setViewName("common/errorPage");
        }
        return mv;
    }
	

 	// 문의 상세보기
    @GetMapping("/qna/detail.ft")
    public ModelAndView showQnaDetail(ModelAndView mv, @RequestParam("qnaNo") int qnaNo) {
		try {
			QnaVO qna = qService.selectByQnaNo(qnaNo);
			if (qna != null) {
				mv.addObject("qna", qna).setViewName("admin/qnaadmindetail");
			} else {
				mv.addObject("msg", "데이터 불러오기가 실패.");
				mv.setViewName("common/errorPage");
			}
		} catch (Exception e) {
			// TODO: handle exception
			mv.addObject("msg", e.getMessage()).setViewName("common/errorPage");
		}
		return mv;
	}
    

 	// 공지사항 수정 페이지 이동
    @GetMapping("/qna/modify.ft")
    public ModelAndView showModifyForm(ModelAndView mv, 
    		@RequestParam("qnaNo") Integer qnaNo) {
		try {
			QnaVO qna = qService.selectByQnaNo(qnaNo);
			if (qna != null) {
				mv.addObject("qna", qna);
				mv.setViewName("qna/modify");
			} else {
				mv.addObject("msg", "데이터 불러오기 실패.");
				mv.setViewName("common/errorPage");
			}
		} catch (Exception e) {
			// TODO: handle exception
			mv.addObject("msg", e.getMessage()).setViewName("common/errorPage");
		}
		return mv;
	}
    
    // 문의 수정
    @PostMapping("/qna/modify.ft")
    public ModelAndView updateQna(ModelAndView mv, 
            @ModelAttribute QnaVO qna, 
            @RequestParam("qnaNo") Integer qnaNo,
            @RequestParam("qnaStatus") String qnaStatus) {
        try {
            qna.setQnaStatus(qnaStatus); // 수정된 qnaStatus를 설정
            qna.setQnaNo(qnaNo); // qnaNo 설정
            int result = qService.updateQna(qna);
            if (result > 0) {
                mv.setViewName("redirect:/qna/list.ft?qnaNo=" + qna.getQnaNo());
            } else {
                mv.addObject("msg", "데이터가 존재하지 않습니다.");
                mv.setViewName("common/errorPage");
            }
        } catch (Exception e) {
            mv.addObject("msg", e.getMessage()).setViewName("common/errorPage");
        }
        return mv;
    }
    
    // 문의 수정
    @PostMapping("/qna/adminModify.ft")
    public ModelAndView updateAdminQna(ModelAndView mv, 
            @ModelAttribute QnaVO qna, 
            @RequestParam("qnaNo") Integer qnaNo,
            @RequestParam("qnaStatus") String qnaStatus) {
        try {
            qna.setQnaStatus(qnaStatus); // 수정된 qnaStatus를 설정
            qna.setQnaNo(qnaNo); // qnaNo 설정
            int result = qService.updateQna(qna);
            if (result > 0) {
                mv.setViewName("redirect:/qna/adminList.ft?qnaNo=" + qna.getQnaNo());
            } else {
                mv.addObject("msg", "데이터가 존재하지 않습니다.");
                mv.setViewName("common/errorPage");
            }
        } catch (Exception e) {
            mv.addObject("msg", e.getMessage()).setViewName("common/errorPage");
        }
        return mv;
    }
    
 	// 문의 삭제
    @GetMapping("/qna/delete.ft")
    public ModelAndView deleteQna(ModelAndView mv, @RequestParam("qnaNo") Integer qnaNo) {
		try {
			int result = qService.deleteQna(qnaNo);
			if (result > 0) {
				mv.setViewName("redirect:/qna/list.ft");
			} else {
				mv.addObject("msg", "데이터가 존재하지 않습니다.").setViewName("common/errorPage");
			}
		} catch (Exception e) {
			// TODO: handle exception
			mv.addObject("msg", e.getMessage()).setViewName("common/errorPage");
		}
		return mv;
	}
	
	
	// 문의 리스트
	@GetMapping("/qna/list.ft")
    public ModelAndView ShowQnaList(ModelAndView mv,
            @RequestParam(value="page", 
            required=false, defaultValue="1") Integer currentPage) {
		try {
			int totalCount = qService.getTotalCount();
			PageInfo pInfo = this.getPageInfo(currentPage, totalCount);
			List<QnaVO> qList = qService.selectQnaList(pInfo);
			mv.addObject("qList", qList);
			mv.addObject("pInfo", pInfo);
			mv.setViewName("qna/qnalist");
		} catch (Exception e) {
			// TODO: handle exception
			mv.addObject("msg", e.getMessage());
			mv.setViewName("common/errorPage");
		}
		return mv;
    };
    
    
    

 	// 페이징 처리
    private PageInfo getPageInfo(Integer currentPage, int totalCount) {
		PageInfo pi = null;
		int boardLimit = 10; // 한 페이지당 보여줄 게시물의 갯수
		
		pi = new PageInfo(currentPage, totalCount, boardLimit);
		return pi;
	}
    
    
    
    

}

