package net.java_school.controller;

import java.util.List;

import net.java_school.bbs.Board;
import net.java_school.bbs.BoardService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	private BoardService boardService;
	
	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String index(Model model) {
		List<Board> list = boardService.getBoards();
		model.addAttribute("list", list);
		
		return "admin/index";
	}
	
	@RequestMapping(value="/createBoard", method=RequestMethod.POST)
	public String createBoard(String boardCd, String boardNm, String boardNm_ko) {
		//boardService.addBoard(boardCd,boardNm,boardNm_ko);
		
		return "redirect:/admin/";
	}
	
}
