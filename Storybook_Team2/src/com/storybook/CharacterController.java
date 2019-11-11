package com.storybook;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;



@Controller
public class CharacterController {

	private static EntityManagerFactory factory;
	private static EntityManager em;
	
	@RequestMapping(value= "/characterList")
	public ModelAndView characterList(String bookId) {
		ModelAndView modelAndView = new ModelAndView("character_list");
		
		factory = Persistence.createEntityManagerFactory("Storybook_Team2");
		em = factory.createEntityManager();

		em.getTransaction().begin();

		Query query = em.createQuery("select c from BookCharacter c where c.bookId = :param").setParameter("param", Integer.parseInt(bookId));
		List<Book> characterList = query.getResultList();
		
		em.close();

		
		modelAndView.addObject("characterList", characterList);
		return modelAndView;
	}
	

	@RequestMapping(value= "/characterUpdateList" ,method = RequestMethod.GET)
	public ModelAndView characterList1(String bookId,int userId) {
		ModelAndView modelAndView = new ModelAndView("character_list_update");
		
		factory = Persistence.createEntityManagerFactory("Storybook_Team2");
		em = factory.createEntityManager();

		em.getTransaction().begin();

		Query query = em.createQuery("select c from BookCharacter c where c.bookId = :param").setParameter("param", Integer.parseInt(bookId));
		List<Book> characterList = query.getResultList();
		
		em.close();

		
		modelAndView.addObject("characterList", characterList);
		return modelAndView;
	}
	
	@RequestMapping(value= "/newCharacter", method = RequestMethod.GET)
	public ModelAndView createNewCharacter(@RequestParam String bookId, int userId) {
		ModelAndView modelAndView = new ModelAndView("newCharacter");
		
		modelAndView.addObject("userId",userId);
		modelAndView.addObject("bookId", bookId);
		return modelAndView;
	}
	@RequestMapping(value= "/newCharacter", method = RequestMethod.POST)
	public ModelAndView createNewCharacteforBook(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView modelAndView = new ModelAndView("character_list_update");
		
		factory = Persistence.createEntityManagerFactory("Storybook_Team2");
		em = factory.createEntityManager();
		
	
		if(!"".equals(request.getParameter("characterId")) && !"".equals(request.getParameter("bookId")) &&
				!"".equals(request.getParameter("name"))) {
			
			System.out.println("Update");
			
			// update
			int characterId  = Integer.parseInt(request.getParameter("characterId"));
			int bookId  = Integer.parseInt(request.getParameter("bookId"));
			
			String name = request.getParameter("name");
			int age = Integer.parseInt(request.getParameter("age"));
			String appereance = request.getParameter("appereance");


			em.getTransaction().begin();
			
			Query query = em.createQuery("update BookCharacter "
										+ "set name = '" + name + "', "
										+ "age = '" + age + "', "
										+ "appereance = '" + appereance + "', "
										+ "bookId = '" + bookId + "' "
										+ "where characterId = " + characterId);
										
			query.executeUpdate();
			
			em.getTransaction().commit();
			em.clear();			
		
			
		}else if(!"".equals(request.getParameter("name"))) {

			System.out.println("insert");
			
			// insert
			int bookId  = Integer.parseInt(request.getParameter("bookId"));	
			System.out.print(bookId);
			String name = request.getParameter("name");
			System.out.print(name);
			int age = Integer.parseInt(request.getParameter("age"));
			System.out.print(age);
			String appereance = request.getParameter("appereance");

			em.getTransaction().begin();

			BookCharacter bookChar = new BookCharacter();
			bookChar.setBookId(bookId);
			bookChar.setName(name);
			bookChar.setAge(age);
			bookChar.setAppereance(appereance);
			
			em.persist(bookChar);
			em.getTransaction().commit();
			em.clear();
			
			
		}		
		
		em.getTransaction().begin();
		
		int bookId  = Integer.parseInt(request.getParameter("bookId"));
		int userId = Integer.parseInt(request.getParameter("userId"));
		
		Query query = em.createQuery("select b from BookCharacter b where b.bookId = " + bookId);
		List<Book> characterList = query.getResultList();

		em.close();		

		modelAndView.addObject("userId",userId);
		modelAndView.addObject("bookId",bookId);
		modelAndView.addObject("characterList", characterList);
		return modelAndView;
	}

}