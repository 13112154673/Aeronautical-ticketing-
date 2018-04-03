package mapper;

import java.util.List;

import pojo.Category;
import system.Page;

public interface CategoryMapper {
	
	public void add(Category category);  
    
    public void delete(int id);  
        
    public Category get(int id);  
      
    public void update(Category category);   
        
    public List<Category> list();
     
    public int count(); 
    
    public List<Category> list(Page page);
    
    public int total(); 
}
