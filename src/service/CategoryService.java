package service;

import java.util.List;

import pojo.Category;
import system.Page;

public interface CategoryService {
	List<Category> list();
	int total();
	List<Category> list(Page page);
}
