package service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapper.CategoryMapper;
import pojo.Category;
import service.CategoryService;
import system.Page;

@Service
public class CategoryServiceImpl implements CategoryService {
	@Autowired
	CategoryMapper categoryMapper;
	
	@Override
	public List<Category> list() {
		return categoryMapper.list();
	}

	@Override
	public int total() {
		return categoryMapper.total();
	}

	@Override
	public List<Category> list(Page page) {
		
		return categoryMapper.list(page);
	}

}
