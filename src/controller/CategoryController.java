package controller;

import java.util.List;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import pojo.Category;
import service.CategoryService;
import system.Page;

@Controller
@RequestMapping("")
public class CategoryController {
	@Autowired
	CategoryService categoryService;
	
	@RequestMapping("listCategory")
	public ModelAndView listCategory(Page page) {
		if(page.getStart()==0) {
			
		}
		ModelAndView mav =new ModelAndView();
		List<Category> c=categoryService.list(page);
		int total=categoryService.total();
		page.caculateLast(total);
		
		mav.addObject("categorylist",c);
		mav.setViewName("listCategory");
		return mav;
		
	}
	
}
